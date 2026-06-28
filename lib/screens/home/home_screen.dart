import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../models/match_model.dart';
import '../../models/career_model.dart';
import '../../services/pandascore_service.dart';
import '../../services/database_service.dart';
import '../main_navigation.dart';
import '../career/career_detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PandaScoreService _api = PandaScoreService();
  final DatabaseService _db = DatabaseService.instance;

  List<PandaMatch> _liveMatches = [];
  List<CareerModel> _recentJobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _api.fetchMatches(),
        _db.getCareers(),
      ]);

      if (mounted) {
        final now = DateTime.now();
        final startOfToday = DateTime(now.year, now.month, now.day);
        final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

        List<PandaMatch> allMatches = results[0] as List<PandaMatch>;

        setState(() {
          _liveMatches = allMatches.where((m) {
            if (m.beginAt.isEmpty) return false;
            DateTime matchTime = DateTime.parse(m.beginAt).toLocal();
            if (m.status == "running") return true;
            if (m.status == "not_started" || m.status == "upcoming") {
              return matchTime.isBefore(endOfToday);
            }
            if (m.status == "finished") {
              return matchTime.isAfter(startOfToday);
            }
            return false;
          }).toList();

          _liveMatches.sort((a, b) {
            if (a.status == "running" && b.status != "running") return -1;
            if (b.status == "running" && a.status != "running") return 1;
            return a.beginAt.compareTo(b.beginAt);
          });

          // Ambil 3 data karir terbaru
          final rawJobs = results[1] as List<Map<String, dynamic>>;
          _recentJobs = rawJobs
              .map((e) => CareerModel.fromMap(e))
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
            SliverAppBar(
              expandedHeight: 180,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildHeaderWithNotifier(),
              ),
              title: const Text(
                "HOKU UNIVERSE",
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC9A227),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Pro Scene Events", "View All", 1),
                    const SizedBox(height: 12),
                    _buildMatchCarousel(),
                    const SizedBox(height: 30),
                    _buildSectionTitle("Strategy & Tactics", "Dojo", 3),
                    const SizedBox(height: 12),
                    _buildTacticsCard(),
                    const SizedBox(height: 30),
                    _buildSectionTitle("Recent Career", "Networking", 2),
                    const SizedBox(height: 12),
                    if (_recentJobs.isEmpty)
                      _buildEmptyState()
                    else
                      Column(
                        children: _recentJobs
                            .map((j) => _buildCareerTile(j))
                            .toList(),
                      ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cari widget _buildUserHeader(user) dan bungkus dengan:
  Widget _buildHeaderWithNotifier() {
    return ValueListenableBuilder(
      valueListenable: AuthService.userNotifier,
      builder: (context, user, child) {
        final userData = user ?? AuthService.currentUser;
        return _buildUserHeader(userData); // Gunakan data terbaru
      },
    );
  }

  Widget _buildUserHeader(UserModel? user) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFC9A227).withOpacity(0.2),
            const Color(0xFF0A0E14),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 80),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFC9A227),
              child: Icon(Icons.person, color: Colors.black, size: 30),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
                Text(
                  user?.currentRank ?? "Unranked",
                  style: const TextStyle(
                    color: Color(0xFFC9A227),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String action, int targetTab) {
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
        TextButton(
          onPressed: () => MainNavigation.of(context)!.index = targetTab,
          child: Text(
            action,
            style: const TextStyle(color: Color(0xFFC9A227), fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchCarousel() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _liveMatches.length,
        itemBuilder: (context, index) {
          final m = _liveMatches[index];
          return GestureDetector(
            onTap: () => MainNavigation.of(context)!.index = 1,
            child: Container(
              width: 260,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: m.status == "running" ? Colors.red : Colors.white10,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _teamIcon(m.teamALogo),
                      if (m.status == "finished")
                        Text(
                          "${m.scoreA} - ${m.scoreB}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        const Text(
                          "VS",
                          style: TextStyle(color: Colors.white24),
                        ),
                      _teamIcon(m.teamBLogo),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${m.teamA} vs ${m.teamB}",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    m.status == "running"
                        ? "LIVE"
                        : DateFormat(
                            'HH:mm',
                          ).format(DateTime.parse(m.beginAt).toLocal()),
                    style: TextStyle(
                      color: m.status == "running" ? Colors.red : Colors.amber,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _teamIcon(String url) => CircleAvatar(
    radius: 18,
    backgroundColor: Colors.white10,
    backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
  );

  Widget _buildTacticsCard() {
    return GestureDetector(
      onTap: () => MainNavigation.of(context)!.index = 3,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A)],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.psychology, color: Colors.white, size: 30),
            SizedBox(height: 10),
            Text(
              "DRAFT SIMULATOR",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Analyze counters with AI Expert System",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareerTile(CareerModel job) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CareerDetailScreen(job: job)),
      ),
      child: Card(
        color: const Color(0xFF161B22),
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: job.type == "Professional"
                ? const Color(0xFFC9A227)
                : Colors.blue,
            child: Text(
              job.teamName[0],
              style: const TextStyle(color: Colors.black),
            ),
          ),
          title: Text(
            job.role,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${job.teamName} • ${job.city}"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 12),
        ),
      ),
    );
  }

  Widget _buildEmptyState() => const Center(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Text("No data found", style: TextStyle(color: Colors.white24)),
    ),
  );
}
