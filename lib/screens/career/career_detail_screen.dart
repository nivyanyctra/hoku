import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/career_model.dart';
import '../../models/user_model.dart';
import '../../services/database_service.dart';
import '../../utils/currency_utils.dart';
import 'add_edit_career_screen.dart';

class CareerDetailScreen extends StatelessWidget {
  final CareerModel job;
  const CareerDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    bool isOwner = job.creatorId == AuthService.currentUser?.id;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        title: const Text("Career Details"),
        actions: [
          if (isOwner) ...[
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditCareerScreen(job: job),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.teamName,
              style: const TextStyle(color: Color(0xFFC9A227), fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              "${job.role} ${job.lane.isNotEmpty ? '(${job.lane})' : ''}",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            _infoRow(Icons.category, "Job Type", job.type),
            _infoRow(
              Icons.location_city,
              "Team Base",
              "${job.city}, ${job.country}",
            ),
            _infoRow(Icons.business, "Work Mode", job.locationType),

            if (job.type == "Professional") ...[
              // Tampilan Gaji Terformat
              _infoRow(
                Icons.payments,
                "Salary",
                CurrencyHelper.formatDisplay(job.salary, job.currency),
              ),
              _infoRow(Icons.timer, "Deadline", job.deadline),
            ],

            const Divider(color: Colors.white10, height: 50),
            const Text(
              "REQUIREMENTS & JOB DESCRIPTION",
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                job.requirements,
                style: const TextStyle(
                  color: Colors.white70,
                  height: 1.6,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final Uri url = Uri.parse(job.applyLink);
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Could not open link")),
                  );
                }
              },
              child: const Text(
                "APPLY / REGISTER NOW",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.white38),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: const TextStyle(color: Colors.white38, fontSize: 13),
          ),
          Expanded(
            child: Text(
              val,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text("Delete Post?"),
        content: const Text("Are you sure you want to remove this vacancy?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseService.instance.deleteCareer(job.id!);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("DELETE"),
          ),
        ],
      ),
    );
  }
}
