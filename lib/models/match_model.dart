class MatchStream {
  final String provider; // YouTube, BiliBili, etc.
  final String url;

  MatchStream({required this.provider, required this.url});
}

class PandaMatch {
  final String id;
  final String leagueName;
  final String leagueLogo;
  final String status; 
  final String beginAt;
  final String teamA;
  final String teamALogo;
  final int scoreA;
  final String teamB;
  final String teamBLogo;
  final int scoreB;
  final String matchName;
  final List<MatchStream> streams; // Daftar stream

  PandaMatch({
    required this.id, required this.leagueName, required this.leagueLogo,
    required this.status, required this.beginAt, required this.teamA,
    required this.teamALogo, required this.scoreA, required this.teamB,
    required this.teamBLogo, required this.scoreB, required this.matchName,
    required this.streams,
  });

  factory PandaMatch.fromJson(Map<String, dynamic> json) {
    var opponents = json['opponents'] as List;
    var results = json['results'] as List;
    
    String tA = "TBD", tAL = "", tB = "TBD", tBL = "";
    int sA = 0, sB = 0;

    if (opponents.isNotEmpty) {
      tA = opponents[0]['opponent']['name'];
      tAL = opponents[0]['opponent']['image_url'] ?? "";
      var resA = results.firstWhere((r) => r['team_id'] == opponents[0]['opponent']['id'], orElse: () => {'score': 0});
      sA = resA['score'];
    }
    if (opponents.length > 1) {
      tB = opponents[1]['opponent']['name'];
      tBL = opponents[1]['opponent']['image_url'] ?? "";
      var resB = results.firstWhere((r) => r['team_id'] == opponents[1]['opponent']['id'], orElse: () => {'score': 0});
      sB = resB['score'];
    }

    // Parsing Streams List
    List<MatchStream> streamList = [];
    if (json['streams_list'] != null) {
      for (var s in json['streams_list']) {
        String rawUrl = s['raw_url'] ?? "";
        if (rawUrl.isNotEmpty) {
          String provider = "Stream";
          if (rawUrl.contains("youtube.com")) {
            provider = "YouTube";
          } else if (rawUrl.contains("bilibili.com")) {
            provider = "BiliBili";
          } else if (rawUrl.contains("twitch.tv")) {
            provider = "Twitch";
          } else if (rawUrl.contains("huya.com")) {
            provider = "Huya";
          }

          streamList.add(MatchStream(provider: provider, url: rawUrl));
        }
      }
    }

    return PandaMatch(
      id: json['id'].toString(),
      leagueName: json['league']['name'],
      leagueLogo: json['league']['image_url'] ?? "",
      status: json['status'],
      beginAt: json['begin_at'] ?? "",
      teamA: tA, teamALogo: tAL, scoreA: sA,
      teamB: tB, teamBLogo: tBL, scoreB: sB,
      matchName: json['name'],
      streams: streamList,
    );
  }
}