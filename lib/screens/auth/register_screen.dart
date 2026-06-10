import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _handleBack() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  void _handleNext() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    } else {
      // Navigasi ke halaman utama setelah register selesai
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117), // Dark Background
      body: SafeArea(
        child: Column(
          children: [
            // 1. Bagian Atas: Indikator (Opsional, agar user tahu progressnya)
            SizedBox(height: 20),
            _buildStepIndicator(),

            // 2. Bagian Tengah (CENTERED CONTENT): Title & Form
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildFormPage(
                    title: "CREATING ACCOUNT",
                    subtitle: "Enter your credentials to join HOKU",
                    children: [
                      _buildTextField("Email Address", Icons.alternate_email),
                      _buildTextField(
                        "Password",
                        Icons.lock_outline,
                        obscure: true,
                      ),
                      _buildTextField(
                        "Confirm Password",
                        Icons.lock_reset,
                        obscure: true,
                      ),
                    ],
                  ),
                  _buildFormPage(
                    title: "PLAYER IDENTITY",
                    subtitle: "This will be shown on your profile",
                    children: [
                      _buildTextField(
                        "In-game Nickname",
                        Icons.person_pin_outlined,
                      ),
                      _buildTextField("UID In-game", Icons.badge_outlined),
                    ],
                  ),
                  _buildFormPage(
                    title: "RANK & SKILLS",
                    subtitle: "Help us find the right team for you",
                    children: [
                      _buildDropdownField("Current Rank"),
                      _buildTextField("Highest Peak Points", Icons.show_chart),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Bagian Bawah (BOTTOM/END): Tombol Navigasi
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  // Tombol Back
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.white24),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _handleBack,
                      child: Text(
                        "BACK",
                        style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Tombol Next/Finish
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC9A227), // Gold
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _handleNext,
                      child: Text(
                        _currentStep == 2 ? "GET STARTED" : "NEXT STEP",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk halaman form yang kontennya di tengah
  Widget _buildFormPage({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // INI YANG MEMBUAT TENGAH
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFC9A227),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
          SizedBox(height: 40),
          // Form fields
          ...children.map(
            (widget) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: widget,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
        prefixIcon: Icon(icon, color: Color(0xFFC9A227), size: 20),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.03),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFFC9A227)),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Center(
            child: Text(
              hint,
              style: TextStyle(color: Colors.white24, fontSize: 14),
            ),
          ),
          dropdownColor: Color(0xFF161B22),
          items:
              [
                    "Bronze",
                    "Silver",
                    "Gold",
                    "Platinum",
                    "Diamond",
                    "Master",
                    "Grandmaster",
                    "Mythic",
                  ]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Center(
                        child: Text(e, style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (val) {},
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 4,
          width: index == _currentStep ? 24 : 12,
          decoration: BoxDecoration(
            color: index == _currentStep ? Color(0xFFC9A227) : Colors.white10,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
