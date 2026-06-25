import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/user_model.dart';
import 'package:intl/intl.dart';

class CareerPage extends StatefulWidget {
  @override
  _CareerPageState createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  List<Map<String, dynamic>> _allJobs = [];
  List<Map<String, dynamic>> _filteredJobs = [];
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  void _loadJobs() async {
    final data = await DatabaseService.instance.getCareers();
    setState(() {
      _allJobs = data;
      _filteredJobs = data;
    });
  }

  void _filter(String val) {
    setState(() {
      _filteredJobs = _allJobs
          .where(
            (j) =>
                j['role'].toLowerCase().contains(val.toLowerCase()) ||
                j['team'].toLowerCase().contains(val.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "CAREER",
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _filter,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: "Search team...",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFC9A227),
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () => _showJobForm(),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _filteredJobs.length,
        itemBuilder: (context, index) {
          final job = _filteredJobs[index];
          bool isOwner = job['creator_id'] == AuthService.currentUser?.id;

          return Card(
            margin: EdgeInsets.only(bottom: 15),
            color: Color(0xFF161B22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.white10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFC9A227),
                        child: Text(
                          job['team'][0],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job['role'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              job['team'],
                              style: TextStyle(color: Color(0xFFC9A227)),
                            ),
                          ],
                        ),
                      ),
                      if (isOwner) ...[
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue, size: 20),
                          onPressed: () => _showJobForm(job: job),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () => _deleteJob(job['id']),
                        ),
                      ] else
                        Icon(Icons.bookmark_border, color: Colors.white54),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 16,
                        color: Colors.green,
                      ),
                      SizedBox(width: 5),
                      Text(job['salary'], style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Requirements: ${job['requirements']}",
                    style: TextStyle(fontSize: 13, color: Colors.white54),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isOwner ? null : () {},
                          child: Text(isOwner ? "MANAGE POST" : "Quick Apply"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isOwner
                                ? Colors.grey
                                : Colors.blueAccent,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      OutlinedButton(onPressed: () {}, child: Text("Details")),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showJobForm({Map<String, dynamic>? job}) {
    final roleCtrl = TextEditingController(text: job?['role']);
    final teamCtrl = TextEditingController(text: job?['team']);
    final reqCtrl = TextEditingController(text: job?['requirements']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(job == null ? "Post New Career" : "Edit Career"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: roleCtrl,
                decoration: InputDecoration(labelText: "Role (e.g. Jungler)"),
              ),
              TextField(
                controller: teamCtrl,
                decoration: InputDecoration(labelText: "Team Name"),
              ),
              TextField(
                controller: reqCtrl,
                decoration: InputDecoration(labelText: "Requirements"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final data = {
                'creator_id': AuthService.currentUser?.id,
                'role': roleCtrl.text,
                'team': teamCtrl.text,
                'requirements': reqCtrl.text,
                'location': 'Jakarta, ID',
                'salary': 'Competitive',
                'created_at': DateFormat('dd MMM yyyy').format(DateTime.now()),
              };

              if (job == null) {
                await DatabaseService.instance.insertCareer(data);
              } else {
                await DatabaseService.instance.updateCareer(job['id'], data);
              }
              Navigator.pop(context);
              _loadJobs();
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteJob(int id) async {
    await DatabaseService.instance.deleteCareer(id);
    _loadJobs();
  }
}
