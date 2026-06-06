enum HeroClass { marksman, mage, assassin, fighter, tank, support }
enum TipeHeroClass { deftMarksman, burstMage, assassinJungler, etc } // contoh sederhana
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
  final String nameCn;
  final String title;
  final String imageAsset; // path ke asset gambar
  final List<HeroClass> heroClass;
  final String subHeroClass; // bebas string
  final String coreAbilities; // bebas string
  final RecommendedLane recommendedLane;
  final TeamFightPosition teamFightPosition;
  final GolemDependency golemDependency;
  final PeakPeriod peakPeriods;
  final Difficulty difficulty;
  final List<Skill> skills;
  final int survivalPercentage;
  final int attackPercentage;
  final int abilityPercentage;
  final int difficultyPercentage;

  // Stats
  final BasicStats basic;
  final OffensiveStats offensive;
  final DefensiveStats defensive;

  final List<Skin> skins;
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
    required this.skills,
    required this.survivalPercentage,
    required this.attackPercentage,
    required this.abilityPercentage,
    required this.difficultyPercentage,
    required this.basic,
    required this.offensive,
    required this.defensive,
    required this.skins,
    required this.bestPartners,
    required this.suppressingHeroes,
    required this.suppressedHeroes,
  });

  // Helper: cek apakah hero memiliki kelas tertentu
  bool hasClass(HeroClass c) => heroClass.contains(c);

  // Helper: ambil string gabungan nama kelas (opsional untuk tampilan)
  String get heroClassString => heroClass.map((e) => e.name).join('/');
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

class Partner {
  final String name;
  final String thumbnail;
  final String description;

  Partner({
    required this.name,
    required this.thumbnail,
    required this.description,
  });
}

class Item {
  final String id;
  final String name;
  final int type;          // 1=Attack, 2=Magic, 3=Defense, 4=Boots, 5=Jungle, 7=Support
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

  String get imageUrl => 'https://game.gtimg.cn/images/yxzj/img201606/summoner/${id}.png';
}

class Emblem {
  final String id;
  final String name;
  final String type;  // red, yellow, blue
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

  String get imageUrl => 'https://game.gtimg.cn/images/yxzj/img201606/mingwen/${id}.png';
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