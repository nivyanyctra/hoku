import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/match_model.dart';
import '../config/api_config.dart';

class PandaScoreService {
  final String _token = ApiConfig.pandaScoreToken;

  Future<List<PandaMatch>> fetchMatches() async {
    final now = DateTime.now();

    // API Limit: 7 hari ke belakang
    final pastLimit = now.subtract(const Duration(days: 7)).toUtc();
    // API Limit: 28 hari ke depan
    final futureLimit = now.add(const Duration(days: 28)).toUtc();

    final String from = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss'Z'",
    ).format(pastLimit);
    final String to = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss'Z'",
    ).format(futureLimit);

    final url =
        "https://api.pandascore.co/kog/matches?token=$_token"
        "&range[begin_at]=$from,$to"
        "&sort=begin_at&per_page=100";

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((m) => PandaMatch.fromJson(m)).toList();
      }
      return [];
    } catch (e) {
      print("API Error: $e");
      return [];
    }
  }
}
