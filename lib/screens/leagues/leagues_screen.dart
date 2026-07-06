import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import '../../services/pandascore_service.dart';
import '../../models/match_model.dart';

class LeaguesPage extends StatefulWidget {
  @override
  _LeaguesPageState createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  final PandaScoreService _api = PandaScoreService();

  List<PandaMatch> _allMatches = [];
  List<PandaMatch> _filteredMatches = [];
  bool _isLoading = true;

  String _searchQuery = "";
  DateTime? _selectedDate;
  String _selectedLeague = "All";

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  // Ambil data satu kali saat awal
  void _loadInitialData() {
    _api.fetchMatches().then((data) {
      if (mounted) {
        setState(() {
          _allMatches = data;
          _isLoading = false;
          _applyFilters();
        });
      }
    });
  }

  void _applyFilters() {
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    setState(() {
      _filteredMatches = _allMatches.where((m) {
        DateTime mDate = DateTime.parse(m.beginAt).toLocal();
        DateTime mDateOnly = DateTime(mDate.year, mDate.month, mDate.day);

        // 1. Logika Tanggal
        bool matchDate;
        if (_selectedDate != null) {
          // Jika user pilih tanggal, tampilkan HANYA tanggal tersebut
          matchDate = mDateOnly.isAtSameMomentAs(_selectedDate!);
        } else {
          // Default: LIVE + UPCOMING + FINISHED HARI INI
          matchDate =
              m.status == "running" ||
              mDate.isAfter(startOfToday) ||
              mDateOnly.isAtSameMomentAs(startOfToday);
        }

        // 2. Logika Search & League
        bool matchSearch =
            m.teamA.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            m.teamB.toLowerCase().contains(_searchQuery.toLowerCase());
        bool matchLeague =
            _selectedLeague == "All" || m.leagueName == _selectedLeague;

        return matchDate && matchSearch && matchLeague;
      }).toList();

      // Sorting
      _filteredMatches.sort((a, b) {
        if (a.status == "running" && b.status != "running") return -1;
        if (b.status == "running" && a.status != "running") return 1;
        return a.beginAt.compareTo(b.beginAt);
      });
    });
  }

  void _setReminder(PandaMatch match) {
    DateTime dt = DateTime.parse(match.beginAt).toLocal();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFC9A227),
        content: Text(
          "Reminder set for ${match.teamA} vs ${match.teamB} at ${DateFormat('HH:mm').format(dt)}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _scheduleReminder(PandaMatch match) {
    // 1. Parse waktu mulai dari API
    DateTime startTime = DateTime.parse(match.beginAt).toLocal();

    // 2. Estimasi waktu selesai (biasanya match MOBA rata-rata 2 jam untuk Bo3)
    DateTime endTime = startTime.add(const Duration(hours: 2));

    // 3. Buat objek Event Kalender
    final Event event = Event(
      title: 'HOKU: ${match.teamA} vs ${match.teamB}',
      description:
          'Nonton turnamen ${match.leagueName} di aplikasi HOKU Universe.\nStream: ${match.streams.isNotEmpty ? match.streams[0].url : "Cek di HOKU"}',
      location: 'HOKU App',
      startDate: startTime,
      endDate: endTime,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 30), // Notifikasi 30 menit sebelum mulai
      ),
      androidParams: const AndroidParams(
        emailInvites: [], // Kosongkan jika tidak butuh invite email
      ),
    );

    // 4. Buka aplikasi kalender bawaan HP
    Add2Calendar.addEvent2Cal(event).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Berhasil membuka kalender!")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "HOKU ESPORTS",
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(children: [_buildSearchBar(), _buildFilterChips()]),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFC9A227)),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await _api.fetchMatches().then(
                  (data) => setState(() => _allMatches = data),
                );
                _applyFilters();
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 90, top: 12, left: 15, right: 15),
                itemCount: _filteredMatches.length,
                itemBuilder: (context, index) =>
                    _buildMatchCard(_filteredMatches[index]),
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.event_note, color: Colors.white24, size: 50),
          const SizedBox(height: 10),
          Text(
            _selectedDate != null
                ? "No matches on this date"
                : "No active matches found",
            style: const TextStyle(color: Colors.white54),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedDate = null;
                _selectedLeague = "All";
                _searchQuery = "";
              });
              _applyFilters();
            },
            child: const Text(
              "Clear Filters",
              style: TextStyle(color: Color(0xFFC9A227)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        onChanged: (v) {
          _searchQuery = v;
          _applyFilters();
        },
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          hintText: "Search team...",
          prefixIcon: const Icon(Icons.search, color: Colors.white24, size: 20),
          filled: true,
          fillColor: Colors.white10,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    List<String> leagues = [
      "All",
      ..._allMatches.map((e) => e.leagueName).toSet(),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          // DATE PICKER CHIP
          ActionChip(
            backgroundColor: _selectedDate != null
                ? const Color(0xFFC9A227)
                : Colors.white10,
            label: Text(
              _selectedDate == null
                  ? "Select Date"
                  : DateFormat('dd MMM yyyy').format(_selectedDate!),
              style: TextStyle(
                color: _selectedDate != null ? Colors.black : Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              // PERBAIKAN: initialDate harus _selectedDate jika ada, supaya tidak balik ke hari ini terus
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate:
                    _selectedDate ??
                    DateTime.now(), // Gunakan tanggal yang sedang aktif
                firstDate: DateTime.now().subtract(
                  const Duration(days: 7),
                ), // Limit 7 hari past
                lastDate: DateTime.now().add(
                  const Duration(days: 28),
                ), // Limit 28 hari upcoming
                builder: (context, child) => Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: Color(0xFFC9A227), // Header warna gold
                      onPrimary: Colors.black,
                      surface: Color(0xFF161B22),
                    ),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) {
                setState(
                  () => _selectedDate = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                  ),
                );
                _applyFilters();
              }
            },
          ),
          const SizedBox(width: 8),
          // LEAGUE CHIPS
          ...leagues.map(
            (league) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(league, style: const TextStyle(fontSize: 10)),
                selected: _selectedLeague == league,
                onSelected: (val) {
                  if (val) setState(() => _selectedLeague = league);
                  _applyFilters();
                },
                selectedColor: const Color(0xFFC9A227),
                labelStyle: TextStyle(
                  color: _selectedLeague == league
                      ? Colors.black
                      : Colors.white70,
                ),
                backgroundColor: Colors.white10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk DateTime.now() tanpa jam
  DateTime now() => DateTime.now();

  // Widget _buildMatchCard sama seperti kode sebelumnya...
  Widget _buildMatchCard(PandaMatch match) {
    DateTime dt = DateTime.parse(match.beginAt).toLocal();
    bool isFinished = match.status == "finished";
    bool isLive = match.status == "running";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: match.status == "running" ? Colors.red : Colors.white10,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (match.leagueLogo.isNotEmpty)
                Image.network(match.leagueLogo, width: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  match.leagueName,
                  style: const TextStyle(color: Colors.white38, fontSize: 9),
                ),
              ),
              _statusBadge(match.status),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _teamInfo(
                match.teamA,
                match.teamALogo,
                isFinished && match.scoreA > match.scoreB,
              ),
              Column(
                children: [
                  if (isFinished)
                    Text(
                      "${match.scoreA} - ${match.scoreB}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  else ...[
                    Text(
                      DateFormat('HH:mm').format(dt),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM').format(dt),
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ],
              ),
              _teamInfo(
                match.teamB,
                match.teamBLogo,
                isFinished && match.scoreB > match.scoreA,
              ),
            ],
          ),
          const SizedBox(height: 15),

          // --- BAGIAN TOMBOL ---
          if (isLive) ...[
            // Tampilkan semua tombol stream yang tersedia
            if (match.streams.isEmpty)
              const Text(
                "LIVE NOW (No Stream Link)",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: match.streams
                    .map((s) => _buildStreamButton(s))
                    .toList(),
              ),
          ] else if (match.status == "not_started") ...[
            // Tombol Pengingat untuk Upcoming
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () =>
                    _scheduleReminder(match), // Panggil fungsi kalender
                icon: const Icon(
                  Icons.edit_calendar,
                  size: 16,
                  color: Colors.black,
                ),
                label: const Text(
                  "SET REMINDER (CALENDAR)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC9A227), // Warna Gold HOK
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ] else ...[
            // Status Finished
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

  // Helper Build Tombol Stream Dinamis
  Widget _buildStreamButton(MatchStream stream) {
    return ElevatedButton(
      onPressed: () => launchUrl(
        Uri.parse(stream.url),
        mode: LaunchMode.externalApplication,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: stream.provider == "YouTube"
            ? Colors.red
            : (stream.provider == "BiliBili" ? Colors.blue : Colors.indigo),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: const Size(120, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        "Watch Live (${stream.provider})",
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _teamInfo(String name, String logo, bool isWinner) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white.withOpacity(0.05),
            child: logo.isNotEmpty
                ? Image.network(logo, width: 32)
                : const Icon(Icons.shield, color: Colors.white10),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
              color: isWinner ? const Color(0xFFC9A227) : Colors.white,
            ),
          ),
          if (isWinner)
            const Icon(Icons.emoji_events, color: Color(0xFFC9A227), size: 14),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color = Colors.blueGrey;
    String label = status.toUpperCase();
    if (status == "running") {
      color = Colors.red;
      label = "LIVE";
    } else if (status == "not_started") {
      label = "UPCOMING";
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
}
