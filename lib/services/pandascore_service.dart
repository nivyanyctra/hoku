import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/match_model.dart';

class PandaScoreService {
  final String _token = "e2xtOL5t19WmILNtohdxZ-fItn1L6G0Rt-WnELwCTGR1KMKevyk";

  // Kita ubah range-nya agar mencakup 30 hari kebelakang sampai masa depan
  // agar user bisa filter tanggal yang sudah lewat lewat DatePicker
  Future<List<PandaMatch>> fetchMatches() async {
    final now = DateTime.now();
    // Ambil data dari 30 hari yang lalu sampai jauh ke depan
    final pastMonth = now.subtract(const Duration(days: 30)).toUtc();
    final String pastIso = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss'Z'",
    ).format(pastMonth);

    final url =
        "https://api.pandascore.co/kog/matches?token=$_token"
        "&range[begin_at]=$pastIso,2030-12-31T23:59:59Z"
        "&sort=begin_at&per_page=100";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((m) => PandaMatch.fromJson(m)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
