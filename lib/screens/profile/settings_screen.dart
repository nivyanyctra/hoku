import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/user_model.dart';
import '../auth/login_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _db = DatabaseService.instance;

  // --- FUNGSI LOGOUT ---
  void _handleLogout() async {
    await _db.clearSession();
    AuthService.currentUser = null;
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  // --- FUNGSI HAPUS AKUN ---
  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          "Delete Account?",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "This action is permanent. All your career posts and profile data will be deleted.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await _db.deleteUser(AuthService.currentUser!.id!);
              _handleLogout();
            },
            child: const Text("DELETE PERMANENTLY"),
          ),
        ],
      ),
    );
  }

  // --- DIALOG UPDATE PROFILE ---
  // lib/screens/profile/settings_page.dart

  void _showUpdateProfileDialog() {
    final nickCtrl = TextEditingController(
      text: AuthService.currentUser?.nickname,
    );
    final uidCtrl = TextEditingController(text: AuthService.currentUser?.uid);
    final emailCtrl = TextEditingController(
      text: AuthService.currentUser?.email,
    ); // Tambah Email
    String selectedRank = AuthService.currentUser?.currentRank ?? "Bronze";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "UPDATE PROFILE",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC9A227),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: "Email Address",
                prefixIcon: Icon(Icons.email, size: 18),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nickCtrl,
              decoration: const InputDecoration(
                labelText: "Nickname",
                prefixIcon: Icon(Icons.person, size: 18),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: uidCtrl,
              decoration: const InputDecoration(
                labelText: "Game UID",
                prefixIcon: Icon(Icons.fingerprint, size: 18),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedRank,
              dropdownColor: const Color(0xFF161B22),
              decoration: const InputDecoration(labelText: "Current Rank"),
              items: [
                "Bronze",
                "Silver",
                "Gold",
                "Platinum",
                "Diamond",
                "Master",
                "Grandmaster",
                "Mythic",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => selectedRank = v!,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFC9A227),
              ),
              onPressed: () async {
                String newEmail = emailCtrl.text.trim();

                // 1. Validasi Input
                if (nickCtrl.text.isEmpty ||
                    uidCtrl.text.isEmpty ||
                    newEmail.isEmpty) {
                  _showMsg("All fields are required");
                  return;
                }

                // 2. Cek apakah email baru sudah dipakai orang lain
                bool isUnique = await _db.isEmailUniqueForUpdate(
                  AuthService.currentUser!.id!,
                  newEmail,
                );
                if (!isUnique) {
                  _showMsg("Email already used by another account");
                  return;
                }

                // 3. Simpan ke Database
                Map<String, dynamic> data = {
                  'email': newEmail,
                  'nickname': nickCtrl.text,
                  'uid': uidCtrl.text,
                  'current_rank': selectedRank,
                };

                await _db.updateProfile(AuthService.currentUser!.id!, data);

                // UPDATE SESSION GLOBAL
                AuthService.updateSession(
                  UserModel(
                    id: AuthService.currentUser!.id,
                    email: newEmail,
                    password: AuthService.currentUser!.password,
                    nickname: nickCtrl.text,
                    uid: uidCtrl.text,
                    currentRank: selectedRank,
                  ),
                );

                Navigator.pop(ctx); // Tutup BottomSheet
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile Updated!")),
                );
                // _showMsg("Profile & Email Updated!");
              },
              child: const Text(
                "SAVE CHANGES",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // --- DIALOG UPDATE PASSWORD ---
  void _showChangePasswordDialog() {
    final passCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          "CHANGE PASSWORD",
          style: TextStyle(color: Color(0xFFC9A227)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            TextField(
              controller: confirmPassCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm New Password",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (passCtrl.text == confirmPassCtrl.text &&
                  passCtrl.text.isNotEmpty) {
                await _db.updatePassword(
                  AuthService.currentUser!.id!,
                  passCtrl.text,
                );
                if (!mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password Changed!")),
                );
              }
            },
            child: const Text("UPDATE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "SETTINGS",
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "ACCOUNT",
              style: TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          _buildTile(
            Icons.person_outline,
            "Update Profile",
            "Change nickname, UID, and rank",
            _showUpdateProfileDialog,
          ),
          _buildTile(
            Icons.lock_outline,
            "Change Password",
            "Secure your account",
            _showChangePasswordDialog,
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "PREFERENCES",
              style: TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          _buildTile(
            Icons.notifications_none,
            "Notifications",
            "Manage alerts",
            () {},
          ),
          _buildTile(Icons.language, "Language", "English (Default)", () {}),

          const Divider(color: Colors.white10, height: 40),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.orangeAccent),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.orangeAccent),
            ),
            onTap: _handleLogout,
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            title: const Text(
              "Delete Account",
              style: TextStyle(color: Colors.redAccent),
            ),
            subtitle: const Text(
              "Permanently remove your data",
              style: TextStyle(fontSize: 11, color: Colors.white24),
            ),
            onTap: _confirmDeleteAccount,
          ),

          const SizedBox(height: 50),
          const Center(
            child: Text(
              "HOKU v1.0.0",
              style: TextStyle(color: Colors.white10, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    IconData icon,
    String title,
    String sub,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFC9A227)),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      subtitle: Text(
        sub,
        style: const TextStyle(fontSize: 11, color: Colors.white38),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 20,
        color: Colors.white10,
      ),
      onTap: onTap,
    );
  }
}
