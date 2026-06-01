enum HeroClass { marksman, mage, assassin, fighter, tank, support }
enum TipeHeroClass { deftMarksman, burstMage, assassinJungler, etc } // contoh sederhana
enum RecommendedLane { farmLane, midLane, clashLane, jungling, roaming }
enum TeamFightPosition { frontline, backline, flank, initiator }
enum GolemType { crimson, azure, both }
enum GolemDependencyLevel { notDependent, slightlyDependent, highlyDependent }
enum PeakPeriod { early, mid, late, balanced }
enum Difficulty { easy, medium, hard, veryHard }
enum AttackRange { melee, ranged }

class GolemDependency {
  final GolemType type;
  final GolemDependencyLevel level; // seberapa tergantung

  const GolemDependency({
    required this.type,
    required this.level,
  });

  // Factory untuk memudahkan pembuatan
  factory GolemDependency.crimson({required GolemDependencyLevel level}) {
    return GolemDependency(type: GolemType.crimson, level: level);
  }

  factory GolemDependency.azure({required GolemDependencyLevel level}) {
    return GolemDependency(type: GolemType.azure, level: level);
  }

  factory GolemDependency.both({required GolemDependencyLevel level}) {
    return GolemDependency(type: GolemType.both, level: level);
  }

  // Contoh nilai statis untuk hero yang berbeda:
  static const GolemDependency notDependent = GolemDependency(type: GolemType.both, level: GolemDependencyLevel.notDependent);
  static const GolemDependency slightlyDependent = GolemDependency(type: GolemType.azure, level: GolemDependencyLevel.slightlyDependent);
  static const GolemDependency highlyDependent = GolemDependency(type: GolemType.crimson, level: GolemDependencyLevel.highlyDependent);
}

class Hero {
  final String id;
  final String name;
  final String imageAsset; // path ke asset gambar
  final List<HeroClass> heroClass;
  final String subHeroClass; // bebas string
  final String coreAbilities; // bebas string
  final RecommendedLane recommendedLane;
  final TeamFightPosition teamFightPosition;
  final GolemDependency golemDependency;
  final PeakPeriod peakPeriods;
  final Difficulty difficulty;

  // Stats
  final BasicStats basic;
  final OffensiveStats offensive;
  final DefensiveStats defensive;

  // Untuk logika counter/synergy (bisa pakai tipe hero atau atribut)
  final List<String> strongAgainst; // daftar id hero yang dikounter
  final List<String> weakAgainst;   // daftar id hero yang mengcounter dirinya
  final List<String> synergies;     // id hero yang synergy bagus

  Hero({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.heroClass,
    required this.subHeroClass,
    required this.coreAbilities,
    required this.recommendedLane,
    required this.teamFightPosition,
    required this.golemDependency,
    required this.peakPeriods,
    required this.difficulty,
    required this.basic,
    required this.offensive,
    required this.defensive,
    this.strongAgainst = const [],
    this.weakAgainst = const [],
    this.synergies = const [],
  });

  // Helper: cek apakah hero memiliki kelas tertentu
  bool hasClass(HeroClass c) => heroClass.contains(c);

  // Helper: ambil string gabungan nama kelas (opsional untuk tampilan)
  String get heroClassString => heroClass.map((e) => e.name).join('/');
}

class BasicStats {
  final int maxHealth;
  final int maxMana;
  final int physicalAttack;
  final int magicalAttack;
  final int physicalDefense;
  final int magicalDefense;

  BasicStats({
    required this.maxHealth,
    required this.maxMana,
    required this.physicalAttack,
    required this.magicalAttack,
    required this.physicalDefense,
    required this.magicalDefense,
  });
}

class OffensiveStats {
  final double movementSpeed;
  final int physicalPierce;
  final int magicalPierce;
  final double attackSpeedBonus; // persen
  final double criticalRate;
  final double criticalDamage;
  final double physicalLifesteal;
  final double magicalLifesteal;
  final double cooldownReduction;
  final AttackRange attackRange;

  OffensiveStats({
    required this.movementSpeed,
    required this.physicalPierce,
    required this.magicalPierce,
    required this.attackSpeedBonus,
    required this.criticalRate,
    required this.criticalDamage,
    required this.physicalLifesteal,
    required this.magicalLifesteal,
    required this.cooldownReduction,
    required this.attackRange,
  });
}

class DefensiveStats {
  final double resistance;
  final int healthPer5s;
  final int manaPer5s;

  DefensiveStats({
    required this.resistance,
    required this.healthPer5s,
    required this.manaPer5s,
  });
}