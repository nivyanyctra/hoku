import '../models/hero.dart';

final heroes = [
  Hero(
    id: 'agudo',
    name: 'Agudo',
    nameCn: "阿古朵",
    title: "Wild Rider",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230918/16950232941899.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Tank Marksman',
    coreAbilities: 'Ranged Harass/Team Buffs',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 90,
    attackPercentage: 30,
    abilityPercentage: 50,
    difficultyPercentage: 40,
    basic: BasicStats(
      maxHealth: 3280, maxMana: 600, physicalAttack: 186, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 15),
    skills: [
      Skill(
        name: 'Mountain Encounter',
        type: SkillType.passive,
        skill: 0,
        abilityType: [AbilityType.release, AbilityType.enhance],
        damage: DamageType.physical,
        cooldown: [0],
        cost: [0],
        description: 'Replace Recovery with Release. Upon releasing monsters, they grant her Gold, EXP, and their respective blessing. Her Basic Attacks drop Seed Mines.',
        imageUrl: 'https://game.gtimg.cn/images/yxzj/img201606/heroimg/533/53300.png',
      ),
      Skill(
        name: 'Wild Growth',
        type: SkillType.active,
        skill: 1,
        abilityType: [AbilityType.summon, AbilityType.speedUp],
        damage: null,
        cooldown: [
          15,
          14.4,
          13.8,
          13.2,
          12.6,
          12
        ],
        cost: [50],
        description: 'Agudo grants Movement Speed and Health recovery to herself and summons in target area, and summons multiple monsters at the center.',
        imageUrl: 'https://game.gtimg.cn/images/yxzj/img201606/heroimg/533/53310.png',
      ),
      Skill(
        name: 'Tumble, Furball!',
        type: SkillType.active,
        skill: 2,
        abilityType: [AbilityType.speedUp, AbilityType.immunity],
        damage: DamageType.physical,
        cooldown: [
          2.5,
          12,
          11.5,
          11,
          10.5,
          10
        ],
        cost: [45],
        description: 'Rolls forward, dealing damage to nearby enemies. Gains immunity against 1 hard crowd control, and damages and launches enemies hit.',
        imageUrl: 'https://game.gtimg.cn/images/yxzj/img201606/heroimg/533/53320.png',
      ),
      Skill(
        name: 'Gorge Mobilization',
        type: SkillType.active,
        skill: 3,
        abilityType: [AbilityType.summon, AbilityType.crowdControl],
        damage: DamageType.physical,
        cooldown: [40, 36, 32],
        cost: [80],
        description: 'Summons Furball to leap to the target direction, inflicting damage and crowd control. Furball then fights independently.',
        imageUrl: 'https://game.gtimg.cn/images/yxzj/img201606/heroimg/533/53330.png',
      ),
    ],
    skins: [
        Skin(
          name: 'Wild Rider',
          rarity: SkinRarity.classic,
          imageUrl: 'https://liquipedia.net/commons/images/a/aa/Agudo_default_allmode.jpg',
        ),
        Skin(
          name: 'Panda Keeper',
          rarity: SkinRarity.common,
          imageUrl: 'https://liquipedia.net/commons/images/f/fb/Agudo_Panda_Keeper_allmode.jpg',
        ),
        Skin(
          name: 'Rain Play',
          rarity: SkinRarity.epic,
          imageUrl: 'https://liquipedia.net/commons/images/1/10/Agudo_Rain_Play_allmode.jpg',
        ),
        Skin(
          name: 'River Spirits',
          rarity: SkinRarity.epic,
          imageUrl: 'https://liquipedia.net/commons/images/0/04/Agudo_River_Spirits_allmode.jpg',
        ),
    ],
    bestPartners: {
      'drbian' : Partner(
        name: 'Dr Bian',
        thumbnail: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703133397987.jpg',
        description: "*translate dari 阿古朵战斗主要依赖召唤出的球球和多只野怪，因此适合与有群体增益能力的队友配合例如扁鹊，让球球和召唤的野怪获得他们的增益效果",
      ),
      'liushan' : Partner(
        name: 'Liu Shan',
        thumbnail: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703129576050.jpg',
        description: "*translate dari 刘婵出色的追击控制能力可以给阿古朵野怪提供输出环境",
      ),
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: 'alessio',
    name: 'Alessio',
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230418/16818092097723.jpeg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Nimble Marksman',
    coreAbilities: 'Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3340, maxMana: 600, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 15),
    skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: 'allain',
    name: 'Allain',
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230831/16934643343041.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Berserker',
    coreAbilities: 'Gap-Close',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3600, maxMana: 0, physicalAttack: 187, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 51, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: 'angela',
    name: 'Angela',
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230217/16766161908896.png',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Burst/Shield',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3328, maxMana: 640, physicalAttack: 172, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 47, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "aoyin",
    name: "Ao'yin",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240702/17199033998089.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Artillery Marksman',
    coreAbilities: 'Crowd Control/Recovery',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3256, maxMana: 600, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "arke",
    name: "Arke",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20241230/17355454812474.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Burst Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3315, maxMana: 0, physicalAttack: 188, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 125.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "arli",
    name: "Arli",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703170603242.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Nimble Marksman',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3219, maxMana: 600, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 39, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "arthur",
    name: "Arthur",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703153883675.jpg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'Charger',
    coreAbilities: '',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3748, maxMana: 0, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 55, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ata",
    name: "Ata",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230215/16764542813508.jpg',
    heroClass: [HeroClass.tank],
    subHeroClass: 'Vanguard Tank',
    coreAbilities: 'Crowd Control/Recovery',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3820, maxMana: 0, physicalAttack: 191, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 81, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "athena",
    name: "Athena",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703165108210.jpg',
    heroClass: [HeroClass.fighter, HeroClass.assassin],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3201, maxMana: 580, physicalAttack: 176, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 390, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "augran",
    name: "Augran",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240711/17206695027388.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3401, maxMana: 580, physicalAttack: 187, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 51, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "baiqi",
    name: "Bai Qi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250401/17434712069413.jpg',
    heroClass: [HeroClass.tank],
    subHeroClass: 'Vanguard Tank',
    coreAbilities: 'Crowd Control',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3745, maxMana: 0, physicalAttack: 181, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "biron",
    name: "Biron",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230531/16855270146877.jpeg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'Heavy Fighter',
    coreAbilities: 'Gap-Close/Crowd Control',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3508, maxMana: 0, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "butterfly",
    name: "Butterfly",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240108/17046820024102.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3400, maxMana: 0, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 57, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "caiyan",
    name: "Cai Yan",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703167217592.jpg',
    heroClass: [HeroClass.support],
    subHeroClass: 'Buff Support',
    coreAbilities: 'Team Buffs/Recovery',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3314, maxMana: 620, physicalAttack: 167, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 38, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "chano",
    name: "Chano",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250311/17416820519392.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Artillery Marksman',
    coreAbilities: 'Initiate/Cleanup',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3299, maxMana: 600, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 37, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "charlotte",
    name: "Charlotte",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230516/16842306944750.jpeg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Charger',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3413, maxMana: 0, physicalAttack: 176, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "chicha",
    name: "Chicha",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20251124/17639699195592.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Charger',
    coreAbilities: 'Maximum Attack Speed/Cleanup',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3472, maxMana: 580, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 390, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 53, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "cirrus",
    name: "Cirrus",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230413/16813709533820.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Burst Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.mid,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3218, maxMana: 0, physicalAttack: 181, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 49, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "consortyu",
    name: "Consort Yu",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703158837337.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Gap-Close/Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3234, maxMana: 600, physicalAttack: 177, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 36, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "daqiao",
    name: "Da Qiao",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230525/16850065881247.jpg',
    heroClass: [HeroClass.support, HeroClass.mage],
    subHeroClass: 'Tactical Support',
    coreAbilities: 'Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3266, maxMana: 620, physicalAttack: 171, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 42, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "daji",
    name: "Daji",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703126892033.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Burst/Initiate',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3295, maxMana: 640, physicalAttack: 172, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "dharma",
    name: "Dharma",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230711/16890714035936.jpeg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'charger',
    coreAbilities: 'Gap-Close/Crowd Control',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3456, maxMana: 580, physicalAttack: 184, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 51, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "direnjie",
    name: "Di Renjie",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703140804795.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3352, maxMana: 600, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 40, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "dianwei",
    name: "Dian Wei",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703135861893.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Berserker',
    coreAbilities: 'Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3595, maxMana: 580, physicalAttack: 171, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 52, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "diaochan",
    name: "Diaochan",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703143944433.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Sustained Damage/True Damage',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3205, maxMana: 640, physicalAttack: 170, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 43, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "dolia",
    name: "Dolia",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20231218/17028717486587.jpg',
    heroClass: [HeroClass.support],
    subHeroClass: 'Buff Support',
    coreAbilities: 'Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3208, maxMana: 620, physicalAttack: 170, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "donghuang",
    name: "Donghuang",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703168222655.jpg',
    heroClass: [HeroClass.support, HeroClass.tank],
    subHeroClass: 'Offensive Support',
    coreAbilities: 'Revorery/Sustained Crowd Control',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3429, maxMana: 620, physicalAttack: 168, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 80, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "drbian",
    name: "Dr Bian",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703133397987.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Sustained Damage/Heal',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3325, maxMana: 640, physicalAttack: 171, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 43, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "dun",
    name: "Dun",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20231113/16998611165120.jpeg',
    heroClass: [HeroClass.tank, HeroClass.fighter],
    subHeroClass: 'Guardian Tank',
    coreAbilities: 'Gap-Close/Crowd Control',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3590, maxMana: 600, physicalAttack: 193, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 84, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "dyadia",
    name: "Dyadia",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240911/17260371074056.jpg',
    heroClass: [HeroClass.support, HeroClass.mage],
    subHeroClass: 'Buff Support',
    coreAbilities: 'Team Buffs/Recovery',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3332, maxMana: 620, physicalAttack: 169, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "erin",
    name: "Erin",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703150778629.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Deft Marksman',
    coreAbilities: 'Sustained Damage',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.mid,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3245, maxMana: 0, physicalAttack: 176, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 39, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "fang",
    name: "Fang",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703158139826.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Artillery Marksman',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3257, maxMana: 600, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 37, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "fatih",
    name: "Fatih",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250513/17471254343131.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Berserker',
    coreAbilities: 'Lifesteal',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3502, maxMana: 0, physicalAttack: 190, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 54, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "feyd",
    name: "Feyd",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250218/17398710057668.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3335, maxMana: 560, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 48, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "flowborn(mage)",
    name: "Flowborn (Mage)",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250612/17497208355981.png',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Sustained Damage',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3270, maxMana: 640, physicalAttack: 170, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "flowborn(marksman)",
    name: "Flowborn (Marksman)",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250612/17497208355981.png',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Nimble Marksman',
    coreAbilities: 'Sustained Damage',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3250, maxMana: 600, physicalAttack: 170, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 40, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "flowborn(tank)",
    name: "Flowborn (Tank)",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250612/17497208355981.png',
    heroClass: [HeroClass.tank, HeroClass.fighter],
    subHeroClass: 'Vanguard Tank',
    coreAbilities: 'Crowd Control',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3650, maxMana: 600, physicalAttack: 188, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 80, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "fuzi",
    name: "Fuzi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703142673410.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Berserker',
    coreAbilities: 'Gap-Close',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3552, maxMana: 0, physicalAttack: 176, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 51, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ganmo",
    name: "Gan & Mo",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230302/16777673649926.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Burst/Long Range Vision',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3251, maxMana: 640, physicalAttack: 165, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "gao",
    name: "Gao",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703130184130.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Sustained Damage/Damage Reduction',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3320, maxMana: 640, physicalAttack: 167, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "gaochanggong",
    name: "Gao Changgong",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703147869734.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Burst Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3340, maxMana: 560, physicalAttack: 183, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 390, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 52, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "garo",
    name: "Garo",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703177656861.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Ranged Harass/Team Buffs',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3282, maxMana: 600, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 39, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "garuda",
    name: "Garuda",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250925/17587939304703.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Poke/Speed Up',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3270, maxMana: 640, physicalAttack: 167, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "guanyu",
    name: "Guan Yu",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230413/16813705518919.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Charger',
    coreAbilities: 'Gap-Close/Initiate',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3667, maxMana: 100, physicalAttack: 176, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 53, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "guiguzi",
    name: "Guiguzi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240407/17124728454584.jpeg',
    heroClass: [HeroClass.support],
    subHeroClass: 'Offensive Support',
    coreAbilities: 'Crowd Control',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3394, maxMana: 620, physicalAttack: 166, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 47, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "hanxin",
    name: "Han Xin",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703146435725.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Gap-Close',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3232, maxMana: 560, physicalAttack: 190, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 47, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "haya",
    name: "Haya",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20251224/17665588023593.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Ranged Harass',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3212, maxMana: 640, physicalAttack: 158, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "heino",
    name: "Heino",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20231218/17028845838364.jpg',
    heroClass: [HeroClass.mage, HeroClass.fighter],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Poke/Recovery',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3313, maxMana: 640, physicalAttack: 165, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "houyi",
    name: "Hou Yi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703155999339.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Crowd Control/Initiate',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3362, maxMana: 600, physicalAttack: 176, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 41, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "huangzhong",
    name: "Huang Zhong",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240226/17089352338657.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Cleanup/Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3318, maxMana: 600, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 39, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "jing",
    name: "Jing",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703179459568.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3343, maxMana: 560, physicalAttack: 186, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 52, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "kaizer",
    name: "Kaizer",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703169941563.jpg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: '',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3476, maxMana: 580, physicalAttack: 188, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "kongming",
    name: "Kongming",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703169296836.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Ambush Mage',
    coreAbilities: 'Burst/Cleanup',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3300, maxMana: 640, physicalAttack: 162, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "kui",
    name: "Kui",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703161062276.jpg',
    heroClass: [HeroClass.support, HeroClass.mage],
    subHeroClass: 'Offensive Support',
    coreAbilities: 'Crowd Control/Initiate',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3657, maxMana: 600, physicalAttack: 181, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 79, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ladysun",
    name: "Lady Sun",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703127505481.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Artillery Marksman',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3329, maxMana: 600, physicalAttack: 179, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 40, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ladyzhen",
    name: "Lady Zhen",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230426/16824932901818.jpeg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Control Mage',
    coreAbilities: 'Crowd Control/Frozen',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3202, maxMana: 640, physicalAttack: 168, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "lam",
    name: "Lam",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703178882043.jpg',
    heroClass: [HeroClass.assassin, HeroClass.fighter],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3312, maxMana: 560, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 51, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "lapulapu",
    name: "Lapulapu",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20251024/17613060798434.jpg',
    heroClass: [HeroClass.support, HeroClass.tank],
    subHeroClass: 'Defensive Support',
    coreAbilities: 'Crowd Control/Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3686, maxMana: 600, physicalAttack: 162, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 88, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "libai",
    name: "Li Bai",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230228/16775657665832.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3257, maxMana: 560, physicalAttack: 181, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 49, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "lixin",
    name: "Li Xin",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703177137916.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Berserker',
    coreAbilities: 'Gap-Close/Crowd Control',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3512, maxMana: 0, physicalAttack: 190, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 52, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "lianpo",
    name: "Lian Po",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230302/16777674853978.png',
    heroClass: [HeroClass.tank],
    subHeroClass: 'Vanguard Tank',
    coreAbilities: 'Crowd Control/Initiate',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3795, maxMana: 0, physicalAttack: 198, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 78, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "liang",
    name: "Liang",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230705/16885472029879.jpeg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Crowd Control Mage',
    coreAbilities: 'Crowd Control/Initiate',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3204, maxMana: 640, physicalAttack: 171, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 43, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "liubang",
    name: "Liu Bang",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240823/17243982122130.jpg',
    heroClass: [HeroClass.tank, HeroClass.mage],
    subHeroClass: 'Guardian Tank',
    coreAbilities: 'Support',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3630, maxMana: 620, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 88, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "liubei",
    name: "Liu Bei",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240306/17097124878002.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Berserker',
    coreAbilities: 'Dash/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3402, maxMana: 580, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 40, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "liushan",
    name: "Liu Shan",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703129576050.jpg',
    heroClass: [HeroClass.support, HeroClass.tank],
    subHeroClass: 'Tactical Support',
    coreAbilities: 'Push/Crowd Control',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3659, maxMana: 600, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 84, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "lubu",
    name: "Lu Bu",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703133925049.jpg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'Heavy Fighter',
    coreAbilities: 'Cleanup',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3587, maxMana: 0, physicalAttack: 192, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 54, manaPer5s: 10),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "luara",
    name: "Luara",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240612/17181825662103.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Carry/Traverse Terrain',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3204, maxMana: 600, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 37, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "lubanno7",
    name: "Luban No.7",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703128161020.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3366, maxMana: 600, physicalAttack: 184, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 42, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "luna",
    name: "Luna",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230816/16921530652873.jpg',
    heroClass: [HeroClass.fighter, HeroClass.mage],
    subHeroClass: 'Charger',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3207, maxMana: 620, physicalAttack: 170, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 52, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "maishiranui",
    name: "Mai Shiranui",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230316/16789568698457.jpeg',
    heroClass: [HeroClass.assassin, HeroClass.mage],
    subHeroClass: 'Ambush Mage',
    coreAbilities: 'Burst/Gap-Close',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3288, maxMana: 0, physicalAttack: 172, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "marcopolo",
    name: "Marco Polo",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703138149203.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'Nimble Marksman',
    coreAbilities: 'Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3207, maxMana: 0, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "mayene",
    name: "Mayene",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230627/16878548857586.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Charger',
    coreAbilities: 'Gap-Close/Crowd Control',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3409, maxMana: 0, physicalAttack: 182, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 49, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "mengya",
    name: "Meng Ya",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240926/17273418482275.jpg',
    heroClass: [HeroClass.marksman],
    subHeroClass: 'DPS Marksman',
    coreAbilities: 'Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3331, maxMana: 0, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 40, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "menki",
    name: "Menki",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230406/16807654443439.jpg',
    heroClass: [HeroClass.fighter, HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Solo/Gap-Close',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3470, maxMana: 0, physicalAttack: 171, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 76, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "miyue",
    name: "Mi Yue",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20241106/17308812684662.jpg',
    heroClass: [HeroClass.mage, HeroClass.fighter],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Sustained Damage/Recovery',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3251, maxMana: 0, physicalAttack: 160, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "milady",
    name: "Milady",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703172302851.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Sustained Damage/Pushing',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3213, maxMana: 640, physicalAttack: 168, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ming",
    name: "Ming",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230719/16897556107282.jpeg',
    heroClass: [HeroClass.support],
    subHeroClass: 'Buff Support',
    coreAbilities: 'Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3330, maxMana: 620, physicalAttack: 168, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 46, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "mozi",
    name: "Mozi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703126271360.jpg',
    heroClass: [HeroClass.mage, HeroClass.fighter],
    subHeroClass: 'Control Mage',
    coreAbilities: 'Crowd Control/Shield',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3372, maxMana: 640, physicalAttack: 178, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 76, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "mulan",
    name: "Mulan",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703150175496.jpg',
    heroClass: [HeroClass.fighter, HeroClass.assassin],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3321, maxMana: 0, physicalAttack: 171, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 54, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "musashi",
    name: "Musashi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703136497048.jpg',
    heroClass: [HeroClass.fighter, HeroClass.assassin],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3300, maxMana: 0, physicalAttack: 177, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 48, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "nakoruru",
    name: "Nakoruru",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230324/16796410514620.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Burst Assassin',
    coreAbilities: 'Gap-Close',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3359, maxMana: 560, physicalAttack: 186, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 47, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "nezha",
    name: "Nezha",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240529/17169519948178.jpeg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'Charger',
    coreAbilities: 'Gap-Close/Damage Absorption',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3526, maxMana: 580, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 185.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 53, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "nuwa",
    name: "Nuwa",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703161648320.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Poke/Teleport',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3226, maxMana: 640, physicalAttack: 163, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "pei",
    name: "Pei",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703171204802.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Ranged Harass/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3238, maxMana: 0, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "sakeer",
    name: "Sakeer",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250116/17370078545570.jpg',
    heroClass: [HeroClass.support, HeroClass.mage],
    subHeroClass: 'Buff Support',
    coreAbilities: 'Crowd Control/Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3331, maxMana: 620, physicalAttack: 140, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 47, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "shangguan",
    name: "Shangguan",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240220/17084011794453.jpg',
    heroClass: [HeroClass.mage, HeroClass.assassin],
    subHeroClass: 'Ambush Mage',
    coreAbilities: 'Burst/Gap-Close',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3389, maxMana: 640, physicalAttack: 161, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 48, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "shi",
    name: "Shi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20241023/17296715275229.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Control Mage',
    coreAbilities: 'Crowd Control/Distance Increases Damage',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3225, maxMana: 640, physicalAttack: 168, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 43, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "shoyue",
    name: "Shoyue",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230726/16903645266838.jpg',
    heroClass: [HeroClass.marksman, HeroClass.assassin],
    subHeroClass: 'Artillery Marksman',
    coreAbilities: 'Ranged Harass',
    recommendedLane: RecommendedLane.farmLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3275, maxMana: 600, physicalAttack: 188, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 10.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 39, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "simayi",
    name: "Sima Yi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20231026/16982922886953.jpeg',
    heroClass: [HeroClass.assassin, HeroClass.mage],
    subHeroClass: 'Burst Assassin',
    coreAbilities: 'Gap-Close',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3257, maxMana: 0, physicalAttack: 173, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "sunbin",
    name: "Sun Bin",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703132847422.jpg',
    heroClass: [HeroClass.support, HeroClass.mage],
    subHeroClass: 'Tactical Support',
    coreAbilities: 'Crowd Control/Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3468, maxMana: 620, physicalAttack: 177, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 360, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "sunce",
    name: "Sun Ce",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703178244653.jpg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'Charger',
    coreAbilities: 'Crowd Control/Initiate',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3624, maxMana: 580, physicalAttack: 166, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 80, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ukyotachibana",
    name: "Ukyo Tachibana",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230512/16838863039745.jpg',
    heroClass: [HeroClass.assassin, HeroClass.fighter],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close/Recovery',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3250, maxMana: 0, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 48, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "umbrosa",
    name: "Umbrosa",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20250801/17540350014771.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Charger',
    coreAbilities: 'Sustained Damage/Resurrect',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3415, maxMana: 580, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "wangzhaojun",
    name: "Wang Zhaojun",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703147254861.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Crowd Control Mage',
    coreAbilities: 'Crowd Control/Frozen',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3206, maxMana: 640, physicalAttack: 166, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "wukong",
    name: "Wukong",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703154655863.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Burst Assassin',
    coreAbilities: 'Gap-Close/Crowd Control',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3334, maxMana: 560, physicalAttack: 183, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 20.0, criticalDamage: 150.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "wuyan",
    name: "Wuyan",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703132162087.jpg',
    heroClass: [HeroClass.fighter, HeroClass.tank],
    subHeroClass: 'Heavy Fighter',
    coreAbilities: 'Crowd Control/Gap-Close',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3702, maxMana: 580, physicalAttack: 178, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 48, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "xiangyu",
    name: "Xiang Yu",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703141357032.jpg',
    heroClass: [HeroClass.tank, HeroClass.fighter],
    subHeroClass: 'Guardian Tank',
    coreAbilities: 'Crowd Control/Tank',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3666, maxMana: 600, physicalAttack: 195, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 76, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "xiaoqiao",
    name: "Xiao Qiao",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230217/16766162404336.png',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Poke/Group Damage',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3200, maxMana: 640, physicalAttack: 163, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "xuance",
    name: "Xuance",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20241212/17339857737156.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.crimson,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3369, maxMana: 560, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 51, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "yangjian",
    name: "Yang jian",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20230203/16754188047634.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close/Cleanup',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3407, maxMana: 580, physicalAttack: 180, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 51, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "yango",
    name: "Yango",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20260129/17696842316548.jpg',
    heroClass: [HeroClass.assassin],
    subHeroClass: 'Roving Assassin',
    coreAbilities: 'Initiate',
    recommendedLane: RecommendedLane.clashLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.veryHard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3001, maxMana: 560, physicalAttack: 175, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 40, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "yao",
    name: "Yao",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240627/17194737011161.jpeg',
    heroClass: [HeroClass.fighter, HeroClass.assassin],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: '',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3304, maxMana: 0, physicalAttack: 173, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 49, manaPer5s: 0),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "yaria",
    name: "Yaria",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703176615337.jpg',
    heroClass: [HeroClass.support],
    subHeroClass: 'Buff Support',
    coreAbilities: 'Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 2913, maxMana: 620, physicalAttack: 165, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 36, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ying",
    name: "Ying",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703119253787.jpg',
    heroClass: [HeroClass.fighter, HeroClass.assassin],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close/Flexible',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.mid,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3394, maxMana: 580, physicalAttack: 183, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 49, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "yixing",
    name: "Yixing",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20241127/17326904276919.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Poke/Crowd Control',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3253, maxMana: 640, physicalAttack: 173, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 45, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "yuhuan",
    name: "Yuhuan",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240430/17144422913129.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Sustained Damage/Heal',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3202, maxMana: 640, physicalAttack: 166, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 42, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "zhangfei",
    name: "Zhang Fei",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703157465676.jpg',
    heroClass: [HeroClass.support, HeroClass.tank],
    subHeroClass: 'Defensive Support',
    coreAbilities: 'Crowd Control/Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3658, maxMana: 0, physicalAttack: 168, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 375, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 86, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "zhouyu",
    name: "Zhou Yu",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703134708376.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Formation Mage',
    coreAbilities: 'Sustained Damage/Pushing',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.highlyDependent,
    ),
    peakPeriods: PeakPeriod.early,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3278, maxMana: 640, physicalAttack: 170, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 365, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 44, manaPer5s: 16),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "zhuangzi",
    name: "Zhuangzi",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703128797542.jpg',
    heroClass: [HeroClass.support, HeroClass.tank],
    subHeroClass: 'Defensive Support',
    coreAbilities: 'Team Buffs',
    recommendedLane: RecommendedLane.roaming,
    teamFightPosition: TeamFightPosition.frontline,
    golemDependency: GolemDependency(
      type: GolemType.both,
      level: GolemDependencyLevel.notDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.easy,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3624, maxMana: 600, physicalAttack: 174, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 380, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 0.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 78, manaPer5s: 15),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "zilong",
    name: "Zilong",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20221206/16703121309130.jpg',
    heroClass: [HeroClass.fighter],
    subHeroClass: 'Assassin Fighter',
    coreAbilities: 'Gap-Close',
    recommendedLane: RecommendedLane.jungling,
    teamFightPosition: TeamFightPosition.flank,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.balanced,
    difficulty: Difficulty.medium,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3468, maxMana: 580, physicalAttack: 185, magicalAttack: 0,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 385, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.melee,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 50, manaPer5s: 14),
  skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
  Hero(
    id: "ziya",
    name: "Ziya",
    nameCn: "",
    title: "",
    imageAsset: 'https://world.honorofkings.com/zlkdatasys/images/image/20240808/17231072409686.jpg',
    heroClass: [HeroClass.mage],
    subHeroClass: 'Artillery Mage',
    coreAbilities: 'Poke/Team Buffs',
    recommendedLane: RecommendedLane.midLane,
    teamFightPosition: TeamFightPosition.backline,
    golemDependency: GolemDependency(
      type: GolemType.azure,
      level: GolemDependencyLevel.slightlyDependent,
    ),
    peakPeriods: PeakPeriod.late,
    difficulty: Difficulty.hard,
    survivalPercentage: 0,
    attackPercentage: 0,
    abilityPercentage: 0,
    difficultyPercentage: 0,
    basic: BasicStats(
      maxHealth: 3222, maxMana: 640, physicalAttack: 172, magicalAttack: 10,
      physicalDefense: 150, magicalDefense: 75,
    ),
    offensive: OffensiveStats(
      movementSpeed: 370, physicalPierce: 0, magicalPierce: 0,
      attackSpeedBonus: 5.0, criticalRate: 0.0, criticalDamage: 200.0,
      physicalLifesteal: 0.0, magicalLifesteal: 0.0, cooldownReduction: 0.0,
      attackRange: AttackRange.ranged,
    ),
    defensive: DefensiveStats(resistance: 0.0, healthPer5s: 42, manaPer5s: 16),
    skills: [
      
    ],
    skins: [
      
    ],
    bestPartners: {
      
    },
    suppressingHeroes: {
      
    },
    suppressedHeroes: {
      
    },
  ),
];