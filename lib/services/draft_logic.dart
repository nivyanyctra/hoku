import '../models/hero_model.dart';

class DraftLogic {
  static List<Map<String, dynamic>> getRecommendations({
    required List<Hero> allHeroes,
    required Set<String> bannedIds,
    required List<Hero> myTeamPicks,
    required List<Hero> enemyTeamPicks,
  }) {
    List<Map<String, dynamic>> recommendations = [];

    final pickedIds = {
      ...myTeamPicks.map((e) => e.id),
      ...enemyTeamPicks.map((e) => e.id),
    };
    final available = allHeroes
        .where((h) => !bannedIds.contains(h.id) && !pickedIds.contains(h.id))
        .toList();

    for (var hero in available) {
      double score = 0;
      List<String> reasons = [];

      // --- 1. LOGIKA LAMA: COUNTER & SYNERGY ---
      for (var enemy in enemyTeamPicks) {
        if (hero.suppressingHeroes.containsKey(enemy.id)) {
          score += 10.0;
          reasons.add("Counter ${enemy.name}");
        }
        if (hero.suppressedHeroes.containsKey(enemy.id)) score -= 7.0;
      }
      for (var ally in myTeamPicks) {
        if (hero.bestPartners.containsKey(ally.id)) {
          score += 5.0;
          reasons.add("Sinergi dengan ${ally.name}");
        }
      }

      // --- 2. LOGIKA BARU: LANE BALANCING ---
      Map<RecommendedLane, int> laneCount = {};
      for (var ally in myTeamPicks) {
        laneCount[ally.recommendedLane] =
            (laneCount[ally.recommendedLane] ?? 0) + 1;
      }

      int currentLaneCount = laneCount[hero.recommendedLane] ?? 0;
      if (hero.recommendedLane != RecommendedLane.roaming &&
          currentLaneCount >= 1) {
        score -= 15; // Penalti berat jika lane bentrok
      } else if (currentLaneCount == 0) {
        score += 10; // Bonus mengisi lane kosong
        reasons.add("Mengisi ${hero.recommendedLane.name}");
      }

      // --- 3. LOGIKA BARU: TEAM FIGHT POSITION (Frontline/Backline) ---
      int frontlineCount = myTeamPicks
          .where(
            (a) =>
                a.teamFightPosition == TeamFightPosition.frontline ||
                a.teamFightPosition == TeamFightPosition.initiator,
          )
          .length;

      int backlineCount = myTeamPicks
          .where(
            (a) =>
                a.teamFightPosition == TeamFightPosition.backline ||
                a.teamFightPosition == TeamFightPosition.flank,
          )
          .length;

      bool isHeroFrontline =
          hero.teamFightPosition == TeamFightPosition.frontline ||
          hero.teamFightPosition == TeamFightPosition.initiator;
      bool isHeroBackline =
          hero.teamFightPosition == TeamFightPosition.backline ||
          hero.teamFightPosition == TeamFightPosition.flank;

      if (isHeroFrontline) {
        if (frontlineCount >= 2) score -= 8;
        if (frontlineCount < 2) {
          score += 7;
          reasons.add("Butuh Frontline");
        }
      }
      if (isHeroBackline) {
        if (backlineCount >= 3) score -= 5;
        if (backlineCount < 2) {
          score += 5;
          reasons.add("Butuh Backline/Damage");
        }
      }

      // --- 4. LOGIKA BARU: PEAK PERIOD BALANCING ---
      int earlyCount = myTeamPicks
          .where((a) => a.peakPeriods == PeakPeriod.early)
          .length;
      int lateCount = myTeamPicks
          .where((a) => a.peakPeriods == PeakPeriod.late)
          .length;

      if (hero.peakPeriods == PeakPeriod.early && earlyCount >= 2) score -= 4;
      if (hero.peakPeriods == PeakPeriod.late && lateCount >= 2) score -= 4;
      if (hero.peakPeriods == PeakPeriod.balanced) {
        score += 2;
      } else if ((hero.peakPeriods == PeakPeriod.early && earlyCount < 1) ||
          (hero.peakPeriods == PeakPeriod.late && lateCount < 1)) {
        reasons.add("Menyeimbangkan Phase Game");
      }

      recommendations.add({
        'hero': hero,
        'score': score,
        'reason': reasons.isEmpty
            ? "Pilihan Fleksibel"
            : reasons.take(2).join(", "),
      });
    }

    recommendations.sort((a, b) => b['score'].compareTo(a['score']));
    return recommendations.take(3).toList();
  }
}
