import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/career_model.dart';
import '../../models/user_model.dart';
import '../../services/database_service.dart';
import '../../utils/currency_utils.dart';

class AddEditCareerScreen extends StatefulWidget {
  final CareerModel? job;
  const AddEditCareerScreen({super.key, this.job});

  @override
  State<AddEditCareerScreen> createState() => _AddEditCareerScreenState();
}

class _AddEditCareerScreenState extends State<AddEditCareerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _teamCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _countryCtrl = TextEditingController();
  final _reqCtrl = TextEditingController();
  final _linkCtrl = TextEditingController();
  final _deadlineCtrl = TextEditingController();

  String _role = "Player";
  String _lane = "Mid";
  String _type = "Professional";
  String _locType = "GH";
  String _selectedCurrency = "IDR";

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _teamCtrl.text = widget.job!.teamName;
      _role = widget.job!.role;
      _lane = widget.job!.lane;
      _type = widget.job!.type;
      _salaryCtrl.text = widget.job!.salary;
      _selectedCurrency = widget.job!.currency;
      _locType = widget.job!.locationType;
      _cityCtrl.text = widget.job!.city;
      _countryCtrl.text = widget.job!.country;
      _reqCtrl.text = widget.job!.requirements;
      _linkCtrl.text = widget.job!.applyLink;
      _deadlineCtrl.text = widget.job!.deadline;
    }
  }

  void _showCurrencyPicker() {
    showDialog(
      context: context,
      builder: (context) {
        List<String> codes = CurrencyHelper.currencies.keys.toList();
        return StatefulBuilder(
          builder: (context, setDS) {
            return AlertDialog(
              backgroundColor: const Color(0xFF161B22),
              title: TextField(
                decoration: const InputDecoration(
                  hintText: "Search Currency...",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (v) => setDS(
                  () => codes = CurrencyHelper.currencies.keys
                      .where(
                        (c) =>
                            c.contains(v.toUpperCase()) ||
                            CurrencyHelper.currencies[c]!['name']!
                                .toLowerCase()
                                .contains(v.toLowerCase()),
                      )
                      .toList(),
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: codes.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(
                      codes[i],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    subtitle: Text(
                      CurrencyHelper.currencies[codes[i]]!['name']!,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      setState(() => _selectedCurrency = codes[i]);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    // Bersihkan link
    String finalLink = _linkCtrl.text.trim();
    if (!finalLink.startsWith('http')) finalLink = 'https://$finalLink';

    final data = CareerModel(
      creatorId: AuthService.currentUser!.id!,
      teamName: _teamCtrl.text,
      role: _role,
      lane: _role == "Player" ? _lane : "",
      type: _type,
      salary: _salaryCtrl.text,
      currency: _selectedCurrency,
      locationType: _locType,
      city: _cityCtrl.text,
      country: _countryCtrl.text,
      requirements: _reqCtrl.text,
      applyLink: finalLink,
      deadline: _deadlineCtrl.text,
      createdAt:
          widget.job?.createdAt ??
          DateFormat('dd MMM yyyy').format(DateTime.now()),
    );

    try {
      if (widget.job == null) {
        await DatabaseService.instance.insertCareer(data.toMap());
      } else {
        await DatabaseService.instance.updateCareer(
          widget.job!.id!,
          data.toMap(),
        );
      }

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      debugPrint("Update Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        title: Text(widget.job == null ? "Post Career" : "Edit Career"),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _label("Team Identity"),
            _input(_teamCtrl, "Team Name", Icons.groups),
            _label("Position"),
            DropdownButtonFormField(
              value: _role,
              dropdownColor: const Color(0xFF161B22),
              items: [
                "Player",
                "Coach",
                "Manager",
                "Analyst",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _role = v!),
            ),
            if (_role == "Player") ...[
              const SizedBox(height: 15),
              _label("Lane"),
              DropdownButtonFormField(
                value: _lane,
                dropdownColor: const Color(0xFF161B22),
                items: ["Mid", "Farm", "Clash", "Jungle", "Roaming"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _lane = v!),
              ),
            ],
            _label("Vacancy Type"),
            Row(children: [_radio("Professional"), _radio("Teman Mabar")]),
            if (_type == "Professional") ...[
              _label("Salary"),
              Row(
                children: [
                  GestureDetector(
                    onTap: _showCurrencyPicker,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_selectedCurrency),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _input(
                      _salaryCtrl,
                      "Amount",
                      Icons.payments,
                      isNumber: true,
                    ),
                  ),
                ],
              ),
              _label("Deadline"),
              _input(_deadlineCtrl, "YYYY-MM-DD", Icons.event, isDate: true),
            ],
            _label("Location"),
            Row(children: [_radioLoc("GH"), _radioLoc("WFH")]),
            Row(
              children: [
                Expanded(child: _input(_cityCtrl, "City", Icons.location_city)),
                const SizedBox(width: 10),
                Expanded(child: _input(_countryCtrl, "Country", Icons.public)),
              ],
            ),
            _label("Details"),
            _input(_reqCtrl, "Job Description", Icons.description, maxLines: 6),
            _input(_linkCtrl, "Application Link", Icons.link),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC9A227),
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: _save,
              child: const Text(
                "PUBLISH",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(
      t,
      style: const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),
  );

  Widget _input(
    TextEditingController c,
    String h,
    IconData i, {
    int maxLines = 1,
    bool isNumber = false,
    bool isDate = false,
  }) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      readOnly: isDate,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      validator: (v) => v!.isEmpty ? "Required" : null,
      onTap: isDate
          ? () async {
              DateTime? p = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );
              if (p != null) c.text = DateFormat('yyyy-MM-dd').format(p);
            }
          : null,
      decoration: InputDecoration(
        hintText: h,
        prefixIcon: Icon(i, size: 18),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _radio(String v) => Expanded(
    child: RadioListTile(
      title: Text(v, style: const TextStyle(fontSize: 11)),
      value: v,
      groupValue: _type,
      onChanged: (val) => setState(() => _type = val!),
    ),
  );
  Widget _radioLoc(String v) => Expanded(
    child: RadioListTile(
      title: Text(v, style: const TextStyle(fontSize: 11)),
      value: v,
      groupValue: _locType,
      onChanged: (val) => setState(() => _locType = val!),
    ),
  );
}
