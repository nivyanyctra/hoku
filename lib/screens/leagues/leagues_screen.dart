import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import ini
import '../../services/pandascore_service.dart';
import '../../models/match_model.dart';
import 'package:intl/intl.dart';

class LeaguesPage extends StatefulWidget {
  @override
  _LeaguesPageState createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  final PandaScoreService _api = PandaScoreService();

  // Fungsi untuk membuka link YouTube
  Future<void> _openStream(String? url) async {
    if (url == null || url.isEmpty) {
      debugPrint("Link tidak tersedia");
      return;
    }

    final Uri uri = Uri.parse(url);

    try {
      // Gunakan mode externalApplication agar langsung membuka aplikasi YouTube/Browser HP
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        debugPrint("Gagal membuka link: $url");
      }
    } catch (e) {
      debugPrint("Error saat mencoba membuka link: $e");
      // Opsi: Tampilkan SnackBar ke user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the stream link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "HOKU SCHEDULE & RESULTS",
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<PandaMatch>>(
        future: _api.fetchMatches(),
        // Di dalam FutureBuilder build method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFC9A227)),
            );
          }

          final matches = snapshot.data ?? [];

          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 50, color: Colors.white24),
                  const SizedBox(height: 10),
                  Text(
                    "No matches for today or upcoming days",
                    style: TextStyle(color: Colors.white54),
                  ),
                  TextButton(
                    onPressed: () => setState(() {}),
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              return _buildMatchCard(matches[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildMatchCard(PandaMatch match) {
    DateTime dt = DateTime.parse(match.beginAt).toLocal();
    DateTime now = DateTime.now();
    bool isToday =
        dt.day == now.day && dt.month == now.month && dt.year == now.year;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: match.status == "running"
              ? Colors.redAccent
              : (isToday
                    ? const Color(0xFFC9A227).withOpacity(0.5)
                    : Colors.white10),
        ),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              if (match.leagueLogo.isNotEmpty)
                Image.network(match.leagueLogo, width: 20, height: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  match.leagueName,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              _statusBadge(match.status),
            ],
          ),
          const Divider(color: Colors.white10, height: 25),

          // Teams
          Row(
            children: [
              Expanded(
                child: _teamSmall(
                  match.teamA,
                  match.teamALogo,
                  CrossAxisAlignment.end,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Text(
                      DateFormat('HH:mm').format(dt),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isToday ? "TODAY" : DateFormat('dd MMM').format(dt),
                      style: TextStyle(
                        fontSize: 9,
                        color: isToday ? Colors.amber : Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _teamSmall(
                  match.teamB,
                  match.teamBLogo,
                  CrossAxisAlignment.start,
                ),
              ),
            ],
          ),

          // Action Button
          if (match.status != "finished") ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: match.status == "running"
                      ? Colors.red
                      : const Color(0xFF1D4ED8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: match.liveUrl != null
                    ? () => _openStream(match.liveUrl)
                    : null,
                child: Text(
                  match.status == "running"
                      ? "WATCH LIVE NOW"
                      : "STREAM NOT AVAILABLE",
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 15),
            const Text(
              "MATCH ENDED",
              style: TextStyle(
                color: Colors.white24,
                fontSize: 9,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _teamSmall(String name, String logo, CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        if (logo.isNotEmpty)
          Image.network(logo, width: 35, height: 35)
        else
          const Icon(Icons.shield, size: 35, color: Colors.white10),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _statusBadge(String status) {
    Color color = Colors.grey;
    String label = status.toUpperCase();
    if (status == "running") {
      color = Colors.red;
      label = "LIVE";
    }
    if (status == "upcoming") {
      color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _teamInfo(String name, String logo) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withOpacity(0.05),
            child: logo.isNotEmpty
                ? Image.network(logo, width: 30)
                : const Icon(Icons.shield, size: 20),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
