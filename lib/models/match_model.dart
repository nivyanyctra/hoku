class PandaMatch {
  final String id;
  final String leagueName;
  final String leagueLogo;
  final String status;
  final String beginAt;
  final String teamA;
  final String teamALogo;
  final String teamB;
  final String teamBLogo;
  final String matchName;
  final String? liveUrl; // Link streaming YouTube/Twitch

  PandaMatch({
    required this.id,
    required this.leagueName,
    required this.leagueLogo,
    required this.status,
    required this.beginAt,
    required this.teamA,
    required this.teamALogo,
    required this.teamB,
    required this.teamBLogo,
    required this.matchName,
    this.liveUrl,
  });

  factory PandaMatch.fromJson(Map<String, dynamic> json) {
    var opponents = json['opponents'] as List;
    String tA = "TBD", tAL = "", tB = "TBD", tBL = "";

    if (opponents.isNotEmpty) {
      tA = opponents[0]['opponent']['name'];
      tAL = opponents[0]['opponent']['image_url'] ?? "";
    }
    if (opponents.length > 1) {
      tB = opponents[1]['opponent']['name'];
      tBL = opponents[1]['opponent']['image_url'] ?? "";
    }

    String? foundUrl = json['live_url'] ?? json['official_stream_url'];
    if (foundUrl == null &&
        json['streams_list'] != null &&
        (json['streams_list'] as List).isNotEmpty) {
      foundUrl =
          json['streams_list'][0]['raw_url']; // Ambil stream pertama jika ada
    }

    return PandaMatch(
      id: json['id'].toString(),
      leagueName: json['league']['name'],
      leagueLogo: json['league']['image_url'] ?? "",
      status: json['status'],
      beginAt: json['begin_at'] ?? "",
      teamA: tA,
      teamALogo: tAL,
      teamB: tB,
      teamBLogo: tBL,
      matchName: json['name'],
      // PandaScore biasanya menaruh link di official_stream_url atau live_url
      liveUrl: foundUrl,
    );
  }
}
