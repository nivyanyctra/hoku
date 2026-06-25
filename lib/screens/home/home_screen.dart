import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../models/match_model.dart';
import '../../services/pandascore_service.dart';
import '../../services/database_service.dart';
import '../leagues/leagues_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PandaScoreService _api = PandaScoreService();
  final DatabaseService _db = DatabaseService.instance;

  List<PandaMatch> _liveMatches = [];
  List<Map<String, dynamic>> _recentJobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    try {
      final results = await Future.wait([
        _api.fetchMatches(),
        _db.getCareers(),
      ]);

      if (mounted) {
        setState(() {
          final now = DateTime.now();
          // Jam 00:00:00 hari ini
          final startOfToday = DateTime(now.year, now.month, now.day);
          // Jam 23:59:59 hari ini
          final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

          List<PandaMatch> allMatches = results[0] as List<PandaMatch>;

          _liveMatches = allMatches.where((m) {
            if (m.beginAt.isEmpty) return false;
            DateTime matchTime = DateTime.parse(m.beginAt).toLocal();

            // 1. Jika SEDANG LIVE (Running): Selalu tampilkan
            if (m.status == "running") return true;

            // 2. Jika AKAN DATANG (Upcoming):
            // Tampilkan HANYA jika waktunya hari ini (sebelum tengah malam nanti)
            if (m.status == "not_started") {
              return matchTime.isBefore(endOfToday);
            }

            // 3. Jika SUDAH SELESAI (Finished):
            // Tampilkan HANYA jika selesainya hari ini (setelah jam 00:00 tadi pagi)
            if (m.status == "finished") {
              return matchTime.isAfter(startOfToday);
            }

            return false;
          }).toList();

          // Sortir agar LIVE tetap di paling kiri
          _liveMatches.sort((a, b) {
            if (a.status == "running" && b.status != "running") return -1;
            if (b.status == "running" && a.status != "running") return 1;
            return a.beginAt.compareTo(b.beginAt);
          });

          _recentJobs = (results[1] as List<Map<String, dynamic>>)
              .take(3)
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      body: RefreshIndicator(
        onRefresh: _loadHomeData,
        color: const Color(0xFFC9A227),
        child: CustomScrollView(
          slivers: [
            // 1. App Bar dengan Header User
            SliverAppBar(
              expandedHeight: 180,
              floating: false,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildUserHeader(user),
              ),
              title: const Text(
                "HOKU UNIVERSE",
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC9A227),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                ),
              ],
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Section: Live & Upcoming Matches
                    _buildSectionTitle("Pro Scene Events", "View All"),
                    const SizedBox(height: 12),
                    const Text(
                      "Today's Schedule & Results",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildMatchCarousel(),

                    const SizedBox(height: 30),

                    // 3. Section: Tactics Lab (Pintasan Draft Simulator)
                    _buildSectionTitle("Strategy & Tactics", ""),
                    const SizedBox(height: 12),
                    _buildTacticsCard(),

                    const SizedBox(height: 30),

                    // 4. Section: Recent Career (Networking)
                    _buildSectionTitle("Trending Careers", "Network"),
                    const SizedBox(height: 12),
                    _recentJobs.isEmpty
                        ? _buildEmptyCareer()
                        : Column(
                            children: _recentJobs
                                .map((j) => _buildCareerTile(j))
                                .toList(),
                          ),

                    const SizedBox(height: 100), // Extra space at bottom
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(UserModel? user) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueAccent.withOpacity(0.2), const Color(0xFF0A0E14)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFFC9A227),
              child: const Icon(Icons.person, color: Colors.black, size: 30),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome back,",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                Text(
                  user?.nickname ?? "Legend",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user?.currentRank ?? "Unranked",
                    style: const TextStyle(
                      color: Color(0xFFC9A227),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (action.isNotEmpty)
          Text(
            action,
            style: const TextStyle(
              color: Color(0xFFC9A227),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  // lib/screens/home/home_screen.dart -> Method _buildMatchCarousel

  Widget _buildMatchCarousel() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_liveMatches.isEmpty)
      return const Text(
        "No matches for today.",
        style: TextStyle(color: Colors.white24),
      );

    return SizedBox(
      height: 150, // Sedikit lebih tinggi untuk menampung skor
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _liveMatches.length,
        itemBuilder: (context, index) {
          final m = _liveMatches[index];
          bool isFinished = m.status == "finished";
          bool isLive = m.status == "running";

          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF161B22),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isLive
                    ? Colors.redAccent
                    : (isFinished
                          ? Colors.white12
                          : const Color(0xFFC9A227).withOpacity(0.3)),
                width: isLive ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Liga & Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      m.leagueName,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 9,
                      ),
                    ),
                    _buildMiniStatusBadge(m.status),
                  ],
                ),
                const SizedBox(height: 10),
                // Teams & Scores
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _teamIcon(m.teamALogo),
                    Column(
                      children: [
                        if (isFinished)
                          Text(
                            "${m.scoreA} - ${m.scoreB}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        else
                          const Text(
                            "VS",
                            style: TextStyle(
                              color: Colors.white24,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),
                    _teamIcon(m.teamBLogo),
                  ],
                ),
                const SizedBox(height: 8),
                // Team Names & Time
                Text(
                  "${m.teamA} vs ${m.teamB}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  isLive
                      ? "WATCHING LIVE"
                      : (isFinished
                            ? "FINAL RESULT"
                            : DateFormat(
                                'HH:mm',
                              ).format(DateTime.parse(m.beginAt).toLocal())),
                  style: TextStyle(
                    color: isLive
                        ? Colors.redAccent
                        : (isFinished ? Colors.white38 : Colors.amber),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Badge Status Kecil
  Widget _buildMiniStatusBadge(String status) {
    Color color = Colors.grey;
    String label = status.toUpperCase();
    if (status == "running") {
      color = Colors.red;
      label = "LIVE";
    }
    if (status == "not_started") {
      color = Colors.blue;
      label = "UPCOMING";
    }
    if (status == "finished") {
      color = Colors.green;
      label = "DONE";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 7,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _teamIcon(String url) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white.withOpacity(0.05),
      backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
      child: url.isEmpty ? const Icon(Icons.shield, size: 20) : null,
    );
  }

  Widget _buildTacticsCard() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LeaguesPage()),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
            image: NetworkImage(
              "https://world.honorofkings.com/zlkdatasys/images/image/20230217/16766161908896.png",
            ),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.psychology, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            const Text(
              "DRAFT SIMULATOR",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Analyze counters and build winning team comps with our AI Expert System.",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFC9A227),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "START ANALYSIS",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareerTile(Map<String, dynamic> job) {
    return Card(
      color: const Color(0xFF161B22),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFC9A227),
          child: Text(
            job['team'][0],
            style: const TextStyle(color: Colors.black),
          ),
        ),
        title: Text(
          job['role'],
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          job['team'],
          style: const TextStyle(fontSize: 11, color: Color(0xFFC9A227)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.white24,
        ),
      ),
    );
  }

  Widget _buildEmptyCareer() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          "No career posts yet.",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
