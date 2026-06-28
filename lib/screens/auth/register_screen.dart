import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Controllers
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nickCtrl = TextEditingController();
  final _uidCtrl = TextEditingController();
  String _selectedRank = "Bronze";

  void _nextStep() async {
    // Validasi Step 0: Email & Pass
    if (_currentStep == 0) {
      if (_emailCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
        _showError("Email dan Password wajib diisi");
        return;
      }
      if (!_emailCtrl.text.contains("@")) {
        _showError("Format email tidak valid");
        return;
      }
    }
    
    // Validasi Step 1: Nickname & UID
    if (_currentStep == 1) {
      if (_nickCtrl.text.isEmpty || _uidCtrl.text.isEmpty) {
        _showError("Nickname dan UID wajib diisi");
        return;
      }
      
      // CEK UNIQUE ke Database
      final error = await DatabaseService.instance.checkUniqueness(
        _emailCtrl.text.trim(), 
        _nickCtrl.text.trim(), 
        _uidCtrl.text.trim()
      );
      
      if (error != null) {
        _showError(error);
        return;
      }
    }

    if (_currentStep < 2) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() => _currentStep++);
    } else {
      _finishRegister();
    }
  }

  void _finishRegister() async {
    final newUser = UserModel(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
      nickname: _nickCtrl.text.trim(),
      uid: _uidCtrl.text.trim(),
      currentRank: _selectedRank,
    );

    await DatabaseService.instance.registerUser(newUser);
    _showSuccess("Registrasi Berhasil! Silakan Login.");
    Navigator.pop(context);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildIndicator(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildStep("ACCOUNT", [
                    _inputField(_emailCtrl, "Email Address", Icons.email),
                    _inputField(_passCtrl, "Password", Icons.lock, obscure: true),
                  ]),
                  _buildStep("IDENTITY", [
                    _inputField(_nickCtrl, "In-Game Nickname", Icons.person),
                    _inputField(_uidCtrl, "Game UID", Icons.fingerprint),
                  ]),
                  _buildStep("RANK", [
                    _buildRankDropdown(),
                  ]),
                ],
              ),
            ),
            _buildNavButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String title, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC9A227))),
          SizedBox(height: 30),
          ...children,
        ],
      ),
    );
  }

  Widget _inputField(TextEditingController ctrl, String hint, IconData icon, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: ctrl,
        obscureText: obscure,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Color(0xFFC9A227)),
          filled: true, fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildRankDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: _selectedRank,
        dropdownColor: Color(0xFF161B22),
        items: ["Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Grandmaster", "Mythic"]
            .map((e) => DropdownMenuItem(child: Center(child: Text(e)), value: e)).toList(),
        onChanged: (v) => setState(() => _selectedRank = v!),
      ),
    );
  }

  Widget _buildNavButtons() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
                  setState(() => _currentStep--);
                },
                child: Text("BACK"),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFC9A227)),
              onPressed: _nextStep,
              child: Text(_currentStep == 2 ? "FINISH" : "NEXT", style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) => AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: 8, width: _currentStep == i ? 24 : 8,
        decoration: BoxDecoration(color: _currentStep == i ? Color(0xFFC9A227) : Colors.white24, borderRadius: BorderRadius.circular(4)),
      )),
    );
  }
}