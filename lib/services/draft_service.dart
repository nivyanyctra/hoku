import '../models/hero.dart';
import '../models/item.dart';

class DraftService {
  // Data hero statis (bisa dari API nanti)
  final List<Hero> allHeroes;

  // Data item statis
  final List<Item> allItems;

  DraftService({required this.allHeroes, required this.allItems});

  // Mendapatkan hero yang tidak banned dan belum dipilih
  List<Hero> getAvailableHeroes(Set<String> bannedIds, Set<String> pickedIds) {
    return allHeroes.where((h) => !bannedIds.contains(h.id) && !pickedIds.contains(h.id)).toList();
  }

  // Rekomendasi hero berdasarkan pick musuh dan teman
  List<Hero> recommendHeroes({
    required List<Hero> enemyPicks,
    required List<Hero> allyPicks,
    required List<Hero> availableHeroes,
    int topN = 5,
  }) {
    // Hitung skor untuk setiap hero available
    List<_HeroScore> scores = [];

    for (var hero in availableHeroes) {
      double score = 0.0;

      // 1. Counter musuh: jika hero strong terhadap musuh, +10 per musuh
      for (var enemy in enemyPicks) {
        if (hero.strongAgainst.contains(enemy.id)) {
          score += 10;
        }
        // jika hero weak terhadap musuh, -5
        if (hero.weakAgainst.contains(enemy.id)) {
          score -= 5;
        }
      }

      // 2. Synergy dengan teman: +5 per synergy
      for (var ally in allyPicks) {
        if (hero.synergies.contains(ally.id)) {
          score += 5;
        }
      }

      // 3. Pertimbangan lane dan posisi (hindari duplikasi lane sederhana)
      // Contoh: hindari memilih hero dengan lane yang sudah ada 2 teman
      int sameLaneCount = allyPicks.where((a) => a.recommendedLane == hero.recommendedLane).length;
      if (sameLaneCount >= 2) score -= 10;

      // 4. Game phase: balance lebih fleksibel
      if (hero.gamePhase == GamePhase.balance) score += 3;

      scores.add(_HeroScore(hero: hero, score: score));
    }

    scores.sort((a, b) => b.score.compareTo(a.score));
    return scores.take(topN).map((e) => e.hero).toList();
  }

  // Rekomendasi item untuk hero kita melawan hero musuh tertentu
  List<Item> recommendItemsAgainstEnemies({
    required Hero myHero,
    required List<Hero> enemyHeroes,
    int topN = 3,
  }) {
    // Hitung skor item berdasarkan kebutuhan counter stat musuh
    List<_ItemScore> scores = [];

    // Hitung kebutuhan defensif: jika banyak musuh physical attack -> cari armor
    int totalPhysicalDamage = 0;
    int totalMagicalDamage = 0;
    for (var enemy in enemyHeroes) {
      totalPhysicalDamage += enemy.basic.physicalAttack;
      totalMagicalDamage += enemy.basic.magicalAttack;
    }

    for (var item in allItems) {
      double score = 0.0;

      // Cek bonus stat yang relevan
      if (totalPhysicalDamage > totalMagicalDamage) {
        // butuh physical defense
        if (item.bonusStats.containsKey('physicalDefense')) {
          score += item.bonusStats['physicalDefense']! / 10;
        }
      } else {
        if (item.bonusStats.containsKey('magicalDefense')) {
          score += item.bonusStats['magicalDefense']! / 10;
        }
      }

      // Counter lifesteal? contoh sederhana
      bool enemyHasLifesteal = enemyHeroes.any((e) => e.offensive.physicalLifesteal > 0 || e.offensive.magicalLifesteal > 0);
      if (enemyHasLifesteal && item.name.contains("Execution") || item.passive?.name.contains("Grievous") == true) {
        score += 20;
      }

      // Item dengan cooldown reduction bagus untuk hero yang butuh skill spam
      if (myHero.offensive.cooldownReduction < 30 && item.bonusStats.containsKey('cooldownReduction')) {
        score += item.bonusStats['cooldownReduction']! / 2;
      }

      scores.add(_ItemScore(item: item, score: score));
    }

    scores.sort((a, b) => b.score.compareTo(a.score));
    return scores.take(topN).map((e) => e.item).toList();
  }
}

class _HeroScore {
  final Hero hero;
  final double score;
  _HeroScore({required this.hero, required this.score});
}

class _ItemScore {
  final Item item;
  final double score;
  _ItemScore({required this.item, required this.score});
}