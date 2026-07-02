import 'package:flutter/material.dart';
import '../../models/career_model.dart';
import '../../models/user_model.dart';
import '../../services/database_service.dart';
import '../../utils/currency_utils.dart';
import 'add_edit_career_screen.dart';
import 'career_detail_screen.dart';

class CareerPage extends StatefulWidget {
  const CareerPage({super.key});

  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  List<CareerModel> _allJobs = [];
  List<CareerModel> _filteredJobs = [];
  bool _isLoading = true;

  // States Filter & Search
  String _searchQuery = "";
  String fRole = "All";
  String fLane = "All";
  String fType = "All";

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  // Fungsi ambil data dari Database
  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    
    final data = await DatabaseService.instance.getCareers();
    
    if (mounted) {
      setState(() {
        _allJobs = data.map((e) => CareerModel.fromMap(e)).toList();
        _applyFilters(); // Terapkan filter setelah data dimuat
        _isLoading = false;
      });
    }
  }

  // Logika Filter Gabungan (Search + Dropdown)
  void _applyFilters() {
    setState(() {
      _filteredJobs = _allJobs.where((job) {
        final matchesSearch = job.teamName.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                             job.role.toLowerCase().contains(_searchQuery.toLowerCase());
        
        final matchesRole = fRole == "All" || job.role == fRole;
        final matchesLane = fLane == "All" || job.lane == fLane;
        final matchesType = fType == "All" || job.type == fType;

        return matchesSearch && matchesRole && matchesLane && matchesType;
      }).toList();
    });
  }

  // Tampilan Bottom Sheet untuk Filter
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("FILTER CAREER", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white10),
                  
                  _buildFilterDrop("Position", fRole, ["All", "Player", "Coach", "Manager", "Analyst"], (v) {
                    setModalState(() => fRole = v!);
                  }),
                  
                  _buildFilterDrop("Lane (For Player)", fLane, ["All", "Mid", "Farm", "Clash", "Jungle", "Roaming"], (v) {
                    setModalState(() => fLane = v!);
                  }),
                  
                  _buildFilterDrop("Job Type", fType, ["All", "Professional", "Teman Mabar"], (v) {
                    setModalState(() => fType = v!);
                  }),

                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber, 
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    ),
                    onPressed: () {
                      _applyFilters();
                      Navigator.pop(context);
                    },
                    child: const Text("APPLY FILTERS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      setModalState(() {
                        fRole = "All"; fLane = "All"; fType = "All";
                      });
                    }, 
                    child: const Center(child: Text("Reset Filters", style: TextStyle(color: Colors.white38)))
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildFilterDrop(String label, String value, List<String> items, Function(String?) onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: const Color(0xFF0D1117),
        decoration: InputDecoration(
          labelText: label, 
          labelStyle: const TextStyle(color: Colors.white38, fontSize: 12),
          border: const UnderlineInputBorder()
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
        onChanged: onChange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("HOKU CAREER", style: TextStyle(color: Color(0xFFC9A227), fontSize: 14, fontWeight: FontWeight.bold)),
        actions: [
          // Tombol Tambah
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Color(0xFFC9A227)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditCareerScreen()))
                .then((value) { if (value == true) _refresh(); }),
          ),
          // Tombol Filter
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterSheet,
          ),
        ],
        // Search Bar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (v) {
                _searchQuery = v;
                _applyFilters();
              },
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Search Team or Role...",
                hintStyle: const TextStyle(color: Colors.white24),
                prefixIcon: const Icon(Icons.search, color: Colors.white24, size: 20),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero,
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
          : _filteredJobs.isEmpty 
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredJobs.length,
                itemBuilder: (context, i) => _buildJobCard(_filteredJobs[i]),
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 50, color: Colors.white10),
          const SizedBox(height: 10),
          const Text("No vacancies found", style: TextStyle(color: Colors.white24)),
          TextButton(onPressed: _refresh, child: const Text("Refresh", style: TextStyle(color: Colors.amber))),
        ],
      ),
    );
  }

  Widget _buildJobCard(CareerModel job) {
    bool isPro = job.type == "Professional";
    // Format Gaji menggunakan Helper
    String displaySalary = job.salary.isEmpty ? "Mabar Only" : CurrencyHelper.formatDisplay(job.salary, job.currency);

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CareerDetailScreen(job: job)))
          .then((value) { if (value == true) _refresh(); }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isPro ? Colors.amber.withOpacity(0.1) : Colors.white10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: isPro ? const Color(0xFFC9A227) : Colors.blueAccent,
                        radius: 22,
                        child: Text(job.teamName[0], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${job.role} ${job.lane.isNotEmpty ? '(${job.lane})' : ''}", 
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                            Text(job.teamName, style: const TextStyle(color: Color(0xFFC9A227), fontSize: 13)),
                          ],
                        ),
                      ),
                      _badge(job.type),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Baris Informasi Inti
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniInfo(Icons.location_on, job.city),
                      _miniInfo(Icons.payments, displaySalary),
                      _miniInfo(Icons.business, job.locationType),
                    ],
                  )
                ],
              ),
            ),
            // Footer Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16))),
              child: Row(
                children: [
                  Text("Posted by ${job.creatorName}", style: const TextStyle(fontSize: 9, color: Colors.white38)),
                  const Spacer(),
                  const Text("Details", style: TextStyle(fontSize: 10, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                  const Icon(Icons.chevron_right, size: 14, color: Colors.blueAccent),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _badge(String type) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: type == "Professional" ? Colors.amber.withOpacity(0.1) : Colors.blue.withOpacity(0.1), 
      borderRadius: BorderRadius.circular(6)
    ),
    child: Text(type.toUpperCase(), style: TextStyle(color: type == "Professional" ? Colors.amber : Colors.blue, fontSize: 8, fontWeight: FontWeight.bold)),
  );

  Widget _miniInfo(IconData icon, String text) => Expanded(
    child: Row(
      children: [
        Icon(icon, size: 14, color: Colors.white38),
        const SizedBox(width: 4),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis)),
      ],
    ),
  );
}