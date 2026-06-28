import 'dart:convert';

enum HeroClass { marksman, mage, assassin, fighter, tank, support }

enum TipeHeroClass {
  deftMarksman,
  burstMage,
  assassinJungler,
  etc,
} // contoh sederhana

enum RecommendedLane { farmLane, midLane, clashLane, jungling, roaming }

enum TeamFightPosition { frontline, backline, flank, initiator }

enum GolemType { crimson, azure, both }

enum GolemDependencyLevel { notDependent, slightlyDependent, highlyDependent }

enum PeakPeriod { early, mid, late, balanced }

enum Difficulty { easy, medium, hard, veryHard }

enum AttackRange { melee, ranged }

enum SkillType { passive, active }

enum AbilityType { release, enhance, summon, speedUp, immunity, crowdControl }

enum DamageType { physical, magical, trueDamage }

enum SkinRarity { classic, common, rare, epic, legend, mythic, flawless }

double survivalPct = 0.0;

class GolemDependency {
  final GolemType type;
  final GolemDependencyLevel level; // seberapa tergantung

  const GolemDependency({required this.type, required this.level});

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
  static const GolemDependency notDependent = GolemDependency(
    type: GolemType.both,
    level: GolemDependencyLevel.notDependent,
  );
  static const GolemDependency slightlyDependent = GolemDependency(
    type: GolemType.azure,
    level: GolemDependencyLevel.slightlyDependent,
  );
  static const GolemDependency highlyDependent = GolemDependency(
    type: GolemType.crimson,
    level: GolemDependencyLevel.highlyDependent,
  );
}

class Partner {
  final String name;
  final String thumbnail;
  final String description;

  Partner({
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory Partner.fromMap(Map<String, dynamic> map) {
    return Partner(
      name: map['target_name'] as String,
      thumbnail: map['thumbnail'] as String? ?? '',
      description: map['description'] as String? ?? '',
    );
  }
}

class Hero {
  final String id, name, nameCn, title, imageAsset, subHeroClass, coreAbilities;
  final List<HeroClass> heroClass;
  final RecommendedLane recommendedLane;
  final TeamFightPosition teamFightPosition;
  final GolemDependency golemDependency;
  final PeakPeriod peakPeriods;
  final Difficulty difficulty;
  final BasicStats basic;
  final OffensiveStats offensive;
  final DefensiveStats defensive;
  final double survivalPct;
  final double attackPct;
  final double abilityPct;
  final Map<String, Partner> bestPartners;
  final Map<String, Partner> suppressingHeroes;
  final Map<String, Partner> suppressedHeroes;

  Hero({
    required this.id,
    required this.name,
    required this.nameCn,
    required this.title,
    required this.imageAsset,
    required this.heroClass,
    required this.subHeroClass,
    required this.coreAbilities,
    required this.recommendedLane,
    required this.teamFightPosition,
    required this.golemDependency,
    required this.peakPeriods,
    required this.difficulty,
    required this.survivalPct,
    required this.attackPct,
    required this.abilityPct,
    required this.basic,
    required this.offensive,
    required this.defensive,
    this.bestPartners = const {},
    this.suppressingHeroes = const {},
    this.suppressedHeroes = const {},
  });

  // Helper: cek apakah hero memiliki kelas tertentu
  bool hasClass(HeroClass c) => heroClass.contains(c);

  // Helper: ambil string gabungan nama kelas (opsional untuk tampilan)
  String get heroClassString => heroClass.map((e) => e.name).join('/');

  // Factory constructor untuk mapping dari DB
  factory Hero.fromMap(
    Map<String, dynamic> map,
    Map<String, Partner> partners,
    Map<String, Partner> suppressing,
    Map<String, Partner> suppressed,
  ) {
    // Helper lokal jika tidak memakai extension di atas
    T safeEnum<T>(List<T> values, String? value) {
      if (value == null) return values.first;
      return values.firstWhere(
        (v) =>
            v.toString().split('.').last.toLowerCase() == value.toLowerCase(),
        orElse: () => values.first,
      );
    }

    return Hero(
      id: map['id'],
      name: map['name'],
      nameCn: map['name_cn'] ?? "",
      title: map['title'] ?? "",
      imageAsset: map['image_asset'] ?? "",
      subHeroClass: map['sub_hero_class'] ?? "",
      coreAbilities: map['core_abilities'] ?? "",
      // Mapping String ke Enum
      // ... (isi semua properti dari map['nama_kolom']) ...
      // Gunakan _safeEnum sebagai pengganti .byName
      heroClass: (jsonDecode(map['hero_class']) as List)
          .map((e) => safeEnum(HeroClass.values, e.toString()))
          .toList(),
      recommendedLane: safeEnum(
        RecommendedLane.values,
        map['recommended_lane'],
      ),
      teamFightPosition: safeEnum(
        TeamFightPosition.values,
        map['team_fight_position'],
      ),
      peakPeriods: safeEnum(PeakPeriod.values, map['peak_periods']),
      difficulty: safeEnum(Difficulty.values, map['difficulty']),
      golemDependency: GolemDependency(
        type: safeEnum(GolemType.values, map['golem_type']),
        level: safeEnum(GolemDependencyLevel.values, map['golem_level']),
      ),
      basic: BasicStats(
        maxHealth: map['max_health'],
        maxMana: map['max_mana'],
        physicalAttack: map['physical_attack'],
        magicalAttack: map['magical_attack'],
        physicalDefense: map['physical_defense'],
        magicalDefense: map['magical_defense'],
      ),
      offensive: OffensiveStats(
        movementSpeed: map['movement_speed'].toDouble(),
        physicalPierce: map['physical_pierce'],
        magicalPierce: map['magical_pierce'],
        attackSpeedBonus: map['attack_speed_bonus'].toDouble(),
        criticalRate: map['critical_rate'].toDouble(),
        criticalDamage: map['critical_damage'].toDouble(),
        physicalLifesteal: map['physical_lifesteal'].toDouble(),
        magicalLifesteal: map['magical_lifesteal'].toDouble(),
        cooldownReduction: map['cooldown_reduction'].toDouble(),
        attackRange: map['attack_range'] == 'ranged'
            ? AttackRange.ranged
            : AttackRange.melee,
      ),
      defensive: DefensiveStats(
        resistance: map['resistance'].toDouble(),
        healthPer5s: map['health_per5s'],
        manaPer5s: map['mana_per5s'],
      ),
      survivalPct: map['survival_pct'].toDouble(),
      attackPct: map['attack_pct'].toDouble(),
      abilityPct: map['ability_pct'].toDouble(),

      // Tambahkan relasi
      bestPartners: partners,
      suppressingHeroes: suppressing,
      suppressedHeroes: suppressed,

      // ... (sisanya sama seperti factory sebelumnya, isi semua properti basic, offensive, defensive)
    );
  }
}

class Skill {
  final String name;
  final SkillType type;
  final int skill;
  final List<AbilityType> abilityType;
  final DamageType? damage;
  final List<double> cooldown;
  final List<int> cost;
  final String description;
  final String imageUrl;

  Skill({
    required this.name,
    required this.type,
    required this.skill,
    required this.abilityType,
    required this.damage,
    required this.cooldown,
    required this.cost,
    required this.description,
    required this.imageUrl,
  });
}

class Skin {
  final String name;
  final SkinRarity rarity;
  final String imageUrl;

  Skin({required this.name, required this.rarity, required this.imageUrl});
}

class Item {
  final String id;
  final String name;
  final int type; // 1=Attack, 2=Magic, 3=Defense, 4=Boots, 5=Jungle, 7=Support
  final int price;
  final int totalPrice;
  final String description1;
  final String? description2;

  Item({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.totalPrice,
    required this.description1,
    this.description2,
  });

  factory Item.fromJson(Map<String, dynamic> json, {required String id}) {
    return Item(
      id: id,
      name: json['item_name'] as String,
      type: json['item_type'] as int,
      price: json['price'] as int,
      totalPrice: json['total_price'] as int,
      description1: json['des1'] as String,
      description2: json['des2'] as String?,
    );
  }

  String get imageUrl =>
      'https://game.gtimg.cn/images/yxzj/img201606/item/${id}.png';
}

class Spell {
  final String id;
  final String name;
  final String rank;
  final String description;

  Spell({
    required this.id,
    required this.name,
    required this.rank,
    required this.description,
  });

  factory Spell.fromJson(Map<String, dynamic> json, {required String id}) {
    return Spell(
      id: id,
      name: json['summoner_name'] as String,
      rank: json['summoner_rank'] as String,
      description: json['summoner_description'] as String,
    );
  }

  String get imageUrl =>
      'https://game.gtimg.cn/images/yxzj/img201606/summoner/${id}.png';
}

class Emblem {
  final String id;
  final String name;
  final String type; // red, yellow, blue
  final int grade;
  final String description;

  Emblem({
    required this.id,
    required this.name,
    required this.type,
    required this.grade,
    required this.description,
  });

  factory Emblem.fromJson(Map<String, dynamic> json, {required String id}) {
    return Emblem(
      id: id,
      name: json['ming_name'] as String,
      type: json['ming_type'] as String,
      grade: json['ming_grade'] as int,
      description: json['ming_des'] as String,
    );
  }

  String get imageUrl =>
      'https://game.gtimg.cn/images/yxzj/img201606/mingwen/${id}.png';
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

class RecommendationResult {
  final Hero hero;
  final double totalFuzzyScore;
  final List<String> reasons;

  RecommendationResult({
    required this.hero,
    required this.totalFuzzyScore,
    required this.reasons,
  });
}
