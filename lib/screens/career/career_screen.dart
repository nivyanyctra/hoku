import 'package:flutter/material.dart';
import '../../models/career_model.dart';
import '../../services/database_service.dart';
import 'add_edit_career_screen.dart';
import 'career_detail_screen.dart';
import '../../utils/currency_utils.dart';

class CareerPage extends StatefulWidget {
  const CareerPage({super.key});

  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  List<CareerModel> _allJobs = [];
  List<CareerModel> _filteredJobs = [];
  bool _isLoading = true;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() => _isLoading = true);
    final data = await DatabaseService.instance.getCareers();
    if (mounted) {
      setState(() {
        _allJobs = data.map((e) => CareerModel.fromMap(e)).toList();
        _applyFilters();
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredJobs = _allJobs.where((j) {
        return j.teamName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            j.role.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "HOKU CAREER",
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // TOMBOL TAMBAH SEKARANG DI SINI (SEBELAH FILTER)
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Color(0xFFC9A227)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditCareerScreen()),
            ).then((_) => _refresh()),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {}, // Panggil Filter Sheet jika perlu
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (v) {
                _searchQuery = v;
                _applyFilters();
              },
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: "Search team or positions...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white24,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.white10,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: const Color(0xFFC9A227),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredJobs.length,
                itemBuilder: (context, i) => _buildJobCard(_filteredJobs[i]),
              ),
      ),
    );
  }

  // Di dalam ListView.builder NetworkingPage -> _buildJobCard

  Widget _buildJobCard(CareerModel job) {
    // FORMAT GAJI DISINI
    String formattedSalary = CurrencyHelper.formatDisplay(
      job.salary,
      job.currency,
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CareerDetailScreen(job: job)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: job.type == "Professional"
                ? Colors.amber.withOpacity(0.2)
                : Colors.white10,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFC9A227),
                  child: Text(
                    job.teamName[0],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.role,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        job.teamName,
                        style: const TextStyle(
                          color: Color(0xFFC9A227),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _info(Icons.location_on, "${job.city}, ${job.country}"),
                _info(Icons.payments, formattedSalary), // Gaji terformat
                _info(Icons.work, job.locationType),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(IconData i, String t) => Row(
    children: [
      Icon(i, size: 14, color: Colors.white38),
      const SizedBox(width: 4),
      Text(t, style: const TextStyle(fontSize: 11, color: Colors.white70)),
    ],
  );

  Widget _miniInfo(IconData i, String t) => Row(
    children: [
      Icon(i, size: 14, color: Colors.white38),
      const SizedBox(width: 4),
      Text(t, style: const TextStyle(fontSize: 11, color: Colors.white70)),
    ],
  );
}
