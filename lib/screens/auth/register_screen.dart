import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(value: (_currentStep + 1) / 3),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildStep(
                    title: "Buat Akun HOKU",
                    content: [
                      TextField(
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                      ),
                    ],
                  ),
                  _buildStep(
                    title: "Detail In-Game",
                    content: [
                      TextField(
                        decoration: InputDecoration(labelText: "Nickname HOK"),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "UID (9-10 Digit)",
                        ),
                      ),
                    ],
                  ),
                  _buildStep(
                    title: "Informasi Rank",
                    content: [
                      DropdownButtonFormField(
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
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) {},
                        decoration: InputDecoration(labelText: "Rank Saat Ini"),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Poin Peak Tertinggi",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color(0xFFC9A227),
                ),
                onPressed: () {
                  if (_currentStep < 2) {
                    setState(() => _currentStep++);
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(_currentStep == 2 ? "FINISH" : "NEXT"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({required String title, required List<Widget> content}) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC9A227),
            ),
          ),
          SizedBox(height: 30),
          ...content.map(
            (w) => Padding(padding: EdgeInsets.only(bottom: 20), child: w),
          ),
        ],
      ),
    );
  }
}
