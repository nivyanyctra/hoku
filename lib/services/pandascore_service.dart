import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Pastikan sudah tambah di pubspec.yaml
import '../models/match_model.dart';

class PandaScoreService {
  final String _token = "e2xtOL5t19WmILNtohdxZ-fItn1L6G0Rt-WnELwCTGR1KMKevyk";

  Future<List<PandaMatch>> fetchMatches() async {
    // 1. Ambil waktu hari ini jam 00:00 dalam format ISO 8601
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day).toUtc();
    final String todayIso = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(startOfToday);

    // 2. Gunakan range[begin_at] untuk mengambil dari hari ini jam 00:00 sampai masa depan (2030)
    // 3. sort=begin_at (Ascending) agar yang paling dekat waktunya muncul paling atas
    final url = "https://api.pandascore.co/kog/matches?"
        "token=$_token"
        "&range[begin_at]=$todayIso,2030-12-31T23:59:59Z"
        "&sort=begin_at"
        "&per_page=100";
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        List<PandaMatch> matches = data.map((m) => PandaMatch.fromJson(m)).toList();

        // 4. Kita sortir manual di Dart agar match yang LIVE (running) selalu paling atas
        // meskipun jam mulainya mungkin lebih lambat dari yang sudah selesai tadi pagi.
        matches.sort((a, b) {
          if (a.status == "running" && b.status != "running") return -1;
          if (b.status == "running" && a.status != "running") return 1;
          return a.beginAt.compareTo(b.beginAt);
        });

        return matches;
      } else {
        throw "Gagal memuat data: ${response.statusCode}";
      }
    } catch (e) {
      print("API Error: $e");
      return [];
    }
  }
}