import '../models/hero_model.dart';

class FuzzyDraftService {
  final List<Hero> allHeroes;

  FuzzyDraftService({required this.allHeroes});

  List<RecommendationResult> recommendHeroesFuzzy({
    required List<Hero> enemyPicks,
    required List<Hero> allyPicks,
    required List<Hero> availableHeroes,
    int topN = 3,
  }) {
    List<RecommendationResult> recommendations = [];

    // ==========================================
    // STEP 1: FUZZIFICATION (Analisis Kondisi Draf)
    // ==========================================
    
    // 1. Hitung kebutuhan Survival/Defensif Tim Kita (0.0 - 1.0)
    double avgAllySurvival = allyPicks.isEmpty 
        ? 50.0 
        : allyPicks.map((h) => h.survivalPct).reduce((a, b) => a + b) / allyPicks.length;
    // Semakin rendah survival tim kita, semakin TINGGI kebutuhan Frontline (Fuzzy Membership)
    double needFrontlineFuzzy = (100.0 - avgAllySurvival) / 100.0; 

    // 2. Hitung kebutuhan Crowd Control / Anti-Lincah (Fuzzy Membership)
    int enemyAgilityCount = enemyPicks.where((e) => 
      e.coreAbilities.contains('Gap-Close') || e.subHeroClass.contains('Nimble')
    ).length;
    double enemyMobilityFuzzy = (enemyAgilityCount / 3.0).clamp(0.0, 1.0);

    // 3. Deteksi Kekosongan Lane (Crisp set untuk Lane Occupancy)
    Set<RecommendedLane> occupiedLanes = allyPicks.map((a) => a.recommendedLane).toSet();

    // 4. Analisis Kebutuhan Damage Tipe Tertentu (Attack vs Ability/Magic)
    double avgAllyAttack = allyPicks.isEmpty ? 0.0 : allyPicks.map((h) => h.attackPct).reduce((a, b) => a + b) / allyPicks.length;
    double avgAllyAbility = allyPicks.isEmpty ? 0.0 : allyPicks.map((h) => h.abilityPct).reduce((a, b) => a + b) / allyPicks.length;
    double needPhysicalFuzzy = (avgAllyAbility > avgAllyAttack) ? (avgAllyAbility - avgAllyAttack) / 100.0 : 0.0;
    double needMagicalFuzzy = (avgAllyAttack > avgAllyAbility) ? (avgAllyAttack - avgAllyAbility) / 100.0 : 0.0;

    // 5. Analisis Fase Game (Peak Period)
    int enemyEarlyHeroCount = enemyPicks.where((e) => e.peakPeriods == PeakPeriod.early).length;
    double enemyEarlyPressureFuzzy = (enemyEarlyHeroCount / 2.0).clamp(0.0, 1.0); 

    // ==========================================
    // STEP 2: FUZZY RULE EVALUATION PER HERO
    // ==========================================
    for (var hero in availableHeroes) {
      List<String> reasons = [];

      double muLane = occupiedLanes.contains(hero.recommendedLane) ? 0.0 : 1.0;

      double muJungler = 0.5; // Default neutral
      if (hero.golemDependency.level == GolemDependencyLevel.highlyDependent) {
        if (hero.recommendedLane == RecommendedLane.jungling && !occupiedLanes.contains(RecommendedLane.jungling)) {
          muJungler = 1.0;
        } else if (occupiedLanes.contains(RecommendedLane.jungling)) {
          muJungler = 0.0;
        }
      }

      // 3. Frontline Suitability (μ_Frontline)
      double muFrontline = 0.5;
      if (hero.teamFightPosition == TeamFightPosition.frontline) {
        if (needFrontlineFuzzy > 0.5) {
          muFrontline = needFrontlineFuzzy;
        }
      } else {
        if (needFrontlineFuzzy > 0.5) {
          muFrontline = 1.0 - needFrontlineFuzzy;
        }
      }

      // 4. CC/Mobility Counter Suitability (μ_CC)
      double muCC = 0.5;
      if (hero.coreAbilities.contains('Crowd Control')) {
        if (enemyMobilityFuzzy > 0.3) {
          muCC = enemyMobilityFuzzy;
        }
      } else {
        if (enemyMobilityFuzzy > 0.3) {
          muCC = 1.0 - enemyMobilityFuzzy;
        }
      }

      // 5. Damage Balance Suitability (μ_Damage)
      double muDamage = 0.5;
      if (needPhysicalFuzzy > 0.2 && hero.attackPct > 60.0) {
        muDamage = needPhysicalFuzzy;
      } else if (needMagicalFuzzy > 0.2 && hero.abilityPct > 60.0) {
        muDamage = needMagicalFuzzy;
      } else if ((needPhysicalFuzzy > 0.2 && hero.abilityPct > 60.0) ||
                 (needMagicalFuzzy > 0.2 && hero.attackPct > 60.0)) {
        muDamage = 0.0;
      }

      // 6. Peak Period Suitability (μ_Peak)
      double muPeak = 0.5;
      if (enemyEarlyPressureFuzzy > 0.5) {
        if (hero.peakPeriods == PeakPeriod.early || hero.peakPeriods == PeakPeriod.balanced) {
          muPeak = enemyEarlyPressureFuzzy;
        } else if (hero.peakPeriods == PeakPeriod.late) {
          muPeak = 1.0 - enemyEarlyPressureFuzzy;
        }
      }

      // 7. Synergy Suitability (μ_Synergy)
      List<String> synergizedAllyNames = [];
      for (var ally in allyPicks) {
        // Cek relasi bestPartners (baik key berupa ID atau Name)
        if (hero.bestPartners.containsKey(ally.name) ||
            hero.bestPartners.containsKey(ally.id) ||
            ally.bestPartners.containsKey(hero.name) ||
            ally.bestPartners.containsKey(hero.id)) {
          synergizedAllyNames.add(ally.name);
        }
      }
      double muSynergy = 0.5;
      if (synergizedAllyNames.isNotEmpty) {
        muSynergy = 0.5 + 0.5 * (synergizedAllyNames.length / 2.0).clamp(0.0, 1.0);
      }

      // 8. Counter Suitability (μ_Counter)
      List<String> counteredEnemyNames = [];
      int suppressedCount = 0;
      for (var enemy in enemyPicks) {
        if (hero.suppressingHeroes.containsKey(enemy.name) ||
            hero.suppressingHeroes.containsKey(enemy.id)) {
          counteredEnemyNames.add(enemy.name);
        }
        if (hero.suppressedHeroes.containsKey(enemy.name) ||
            hero.suppressedHeroes.containsKey(enemy.id)) {
          suppressedCount++;
        }
      }
      double netCounter = counteredEnemyNames.length * 1.5 - suppressedCount * 1.0;
      double muCounter = 0.5 + (netCounter / 3.0).clamp(-0.5, 0.5);

      // ==========================================
      // STEP 3: DEFUZZIFICATION (Sugeno Weighted Average Method)
      // ==========================================
      // Defuzzifikasi dilakukan dengan menghitung rata-rata tertimbang (weighted average)
      // dari derajat keanggotaan (μ) setiap aturan/kriteria dikalikan nilai output singleton (0 - 100).
      
      // Bobot kepentingan untuk masing-masing kriteria
      const double wLane = 10.0;
      const double wJungler = 3.0;
      const double wFrontline = 4.0;
      const double wCC = 3.0;
      const double wDamage = 2.5;
      const double wPeak = 2.0;
      const double wSynergy = 4.0;
      const double wCounter = 4.5;

      const double totalWeight = wLane + wJungler + wFrontline + wCC + wDamage + wPeak + wSynergy + wCounter;

      double weightedSum = (muLane * 100.0 * wLane) +
                           (muJungler * 100.0 * wJungler) +
                           (muFrontline * 100.0 * wFrontline) +
                           (muCC * 100.0 * wCC) +
                           (muDamage * 100.0 * wDamage) +
                           (muPeak * 100.0 * wPeak) +
                           (muSynergy * 100.0 * wSynergy) +
                           (muCounter * 100.0 * wCounter);

      double finalFuzzyScore = weightedSum / totalWeight;

      // ==========================================
      // REASON GENERATION BASED ON ACTIVE RULES
      // ==========================================
      if (muLane > 0.8) {
        reasons.add("Mengisi lane ${hero.recommendedLane.name.toUpperCase()} yang belum diisi tim.");
      }
      if (muJungler > 0.9) {
        reasons.add("Sangat cocok karena tim butuh core Jungler.");
      }
      if (muFrontline > 0.8 && hero.teamFightPosition == TeamFightPosition.frontline) {
        reasons.add("Tim butuh frontline (Survival tim rendah). ${hero.name} membantu dengan survival tinggi (${hero.survivalPct.toStringAsFixed(0)}%).");
      }
      if (muCC > 0.6 && hero.coreAbilities.contains('Crowd Control')) {
        reasons.add("Musuh lincah/mobile. Crowd Control ${hero.name} dapat menguncinya.");
      }
      if (muDamage > 0.6) {
        if (needPhysicalFuzzy > 0.2 && hero.attackPct > 60.0) {
          reasons.add("Tim kelebihan Magic Damage, hero ini memberikan Physical Attack alternatif.");
        } else if (needMagicalFuzzy > 0.2 && hero.abilityPct > 60.0) {
          reasons.add("Tim kekurangan Magic Damage, skill output hero ini menyeimbangkan draf.");
        }
      }
      if (muPeak > 0.6) {
        reasons.add("Musuh kuat di early game, hero ini kuat di early/balanced untuk menahan gank.");
      }
      if (synergizedAllyNames.isNotEmpty) {
        reasons.add("Sinergi sangat baik dengan: ${synergizedAllyNames.join(', ')}.");
      }
      if (counteredEnemyNames.isNotEmpty) {
        reasons.add("Counter kuat terhadap hero musuh: ${counteredEnemyNames.join(', ')}.");
      }

      recommendations.add(RecommendationResult(
        hero: hero,
        totalFuzzyScore: finalFuzzyScore,
        reasons: reasons,
      ));
    }

    // Sort berdasarkan skor fuzzy tertinggi
    recommendations.sort((a, b) => b.totalFuzzyScore.compareTo(a.totalFuzzyScore));
    return recommendations.take(topN).toList();
  }
}