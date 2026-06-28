import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/hero_model.dart';

class HokItem {
  final String name;
  final String category;
  final Map<String, double> stats;
  final String passive;
  final String imageUrl;

  HokItem({
    required this.name,
    required this.category,
    required this.stats,
    required this.passive,
    required this.imageUrl,
  });

  factory HokItem.fromJson(String name, Map<String, dynamic> json) {
    Map<String, double> parsedStats = {};
    if (json['stats'] != null) {
      (json['stats'] as Map<String, dynamic>).forEach((key, value) {
        parsedStats[key] = (value as num).toDouble();
      });
    }
    return HokItem(
      name: name,
      category: json['category'] as String? ?? 'Physical',
      stats: parsedStats,
      passive: json['passive'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }
}

class ItemRecommendationResult {
  final List<HokItem> items;
  final List<String> firedRules;

  ItemRecommendationResult({required this.items, required this.firedRules});
}

class ItemRecommendationService {
  static final ItemRecommendationService instance = ItemRecommendationService._init();
  
  Map<String, HokItem> _items = {};
  bool _isLoaded = false;

  ItemRecommendationService._init();

  Future<void> loadItems() async {
    if (_isLoaded) return;
    try {
      final jsonString = await rootBundle.loadString('assets/database/items.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _items = jsonMap.map((key, value) => MapEntry(key, HokItem.fromJson(key, value)));
      _isLoaded = true;
    } catch (e) {
      // Fallback or print error
    }
  }

  bool get isLoaded => _isLoaded;
  Map<String, HokItem> get items => _items;

  ItemRecommendationResult recommendItems({
    required Hero hero,
    required List<Hero> enemyPicks,
    required List<Hero> allyPicks,
  }) {
    List<String> rulesFired = [];

    // 1. Analyze facts
    final lane = hero.recommendedLane;
    final isJungling = lane == RecommendedLane.jungling;
    final isRoaming = lane == RecommendedLane.roaming;

    // Check primary damage type of hero
    final bool isMagicalHero = hero.heroClass.contains(HeroClass.mage) || 
        (hero.basic.magicalAttack > hero.basic.physicalAttack);
    final String primaryDamageType = isMagicalHero ? "Magical" : "Physical";

    // Analyze enemies
    int enemyPhysicalCount = 0;
    int enemyMagicalCount = 0;
    int enemyCcCount = 0;
    int enemyRegenCount = 0;
    int enemyTankCount = 0;

    for (var enemy in enemyPicks) {
      bool enemyIsMagical = enemy.heroClass.contains(HeroClass.mage) || 
          (enemy.basic.magicalAttack > enemy.basic.physicalAttack);
      if (enemyIsMagical) {
        enemyMagicalCount++;
      } else {
        enemyPhysicalCount++;
      }

      final abilitiesLower = enemy.coreAbilities.toLowerCase();
      if (abilitiesLower.contains("crowd control") || 
          abilitiesLower.contains("control") || 
          enemy.heroClass.contains(HeroClass.support) || 
          enemy.heroClass.contains(HeroClass.tank)) {
        enemyCcCount++;
      }

      if (abilitiesLower.contains("heal") || 
          abilitiesLower.contains("lifesteal") || 
          abilitiesLower.contains("recovery") || 
          enemy.offensive.physicalLifesteal > 0.05 || 
          enemy.offensive.magicalLifesteal > 0.05) {
        enemyRegenCount++;
      }

      if (enemy.heroClass.contains(HeroClass.tank) || 
          enemy.basic.maxHealth > 5000 || 
          enemy.defensive.resistance > 50) {
        enemyTankCount++;
      }
    }

    // --- 1. CHOOSE MOVEMENT ITEM (Boots) ---
    HokItem? movementItem;
    if (enemyCcCount >= 2) {
      movementItem = _getItemByName("Boots of Resistance");
      if (movementItem != null) {
        rulesFired.add("Musuh memiliki banyak CC ($enemyCcCount hero), direkomendasikan Boots of Resistance untuk mempersingkat durasi CC.");
      }
    } 
    
    if (movementItem == null && primaryDamageType == "Magical") {
      movementItem = _getItemByName("Boots of the Arcane");
      if (movementItem != null) {
        rulesFired.add("Hero bertipe Magic Attack, direkomendasikan Boots of the Arcane untuk penetrasi sihir dan mana.");
      }
    }

    if (movementItem == null && hero.heroClass.contains(HeroClass.marksman)) {
      movementItem = _getItemByName("Boots of Dexterity");
      if (movementItem != null) {
        rulesFired.add("Hero Marksman membutuhkan Attack Speed, direkomendasikan Boots of Dexterity.");
      }
    }

    if (movementItem == null && enemyPhysicalCount >= 3 && (hero.heroClass.contains(HeroClass.tank) || hero.heroClass.contains(HeroClass.fighter))) {
      movementItem = _getItemByName("Boots of Fortitude");
      if (movementItem != null) {
        rulesFired.add("Musuh didominasi serangan Physical, direkomendasikan Boots of Fortitude untuk meningkatkan physical defense.");
      }
    }

    // Fallback Boots
    if (movementItem == null) {
      movementItem = _getItemByName("Boots of Resistance");
      if (movementItem != null) {
        rulesFired.add("Direkomendasikan Boots of Resistance sebagai pilihan sepatu standar untuk ketahanan crowd control.");
      }
    }

    // --- 2. CHOOSE JUNGLING / ROAMING ITEM ---
    HokItem? specialItem;
    if (isJungling) {
      if (primaryDamageType == "Magical") {
        specialItem = _getItemByName("Runeblade");
        if (specialItem != null) {
          rulesFired.add("Hero Jungler bertipe Magical, direkomendasikan Runeblade untuk meningkatkan Magic Attack.");
        }
      } else if (hero.heroClass.contains(HeroClass.tank) || hero.heroClass.contains(HeroClass.support)) {
        specialItem = _getItemByName("Giant’s Grip");
        if (specialItem != null) {
          rulesFired.add("Jungler bertipe Tank/Support, direkomendasikan Giant's Grip untuk meningkatkan HP maksimum.");
        }
      } else {
        specialItem = _getItemByName("Rapacious Bite");
        if (specialItem != null) {
          rulesFired.add("Jungler bertipe Physical, direkomendasikan Rapacious Bite untuk meningkatkan Physical Attack.");
        }
      }
    } else if (isRoaming) {
      if (enemyCcCount >= 2 || enemyTankCount >= 2) {
        specialItem = _getItemByName("Guardian");
        if (specialItem != null) {
          rulesFired.add("Musuh memiliki banyak CC/Tank, direkomendasikan Guardian untuk meningkatkan defense tim.");
        }
      } else if (hero.heroClass.contains(HeroClass.support) && hero.offensive.attackSpeedBonus > 0) {
        specialItem = _getItemByName("Crimson Shadow");
        if (specialItem != null) {
          rulesFired.add("Hero Support ofensif, direkomendasikan Crimson Shadow untuk menambah Attack Speed rekan tim.");
        }
      } else {
        specialItem = _getItemByName("Stormchaser");
        if (specialItem != null) {
          rulesFired.add("Direkomendasikan Stormchaser untuk meningkatkan mobilitas dan inisiasi tim.");
        }
      }
    }

    // --- 3. GATHER CORE/SITUATIONAL ITEMS ---
    List<HokItem> coreAndSituational = [];

    // Rule: Anti-Heal
    if (enemyRegenCount >= 1) {
      if (primaryDamageType == "Physical") {
        HokItem? antiHeal = _getItemByName("Mortal Punisher");
        if (antiHeal != null) {
          coreAndSituational.add(antiHeal);
          rulesFired.add("Musuh memiliki regenerasi tinggi/lifesteal, direkomendasikan Mortal Punisher untuk membatasi penyembuhan.");
        }
      } else {
        HokItem? antiHeal = _getItemByName("Venomous Staff");
        if (antiHeal != null) {
          coreAndSituational.add(antiHeal);
          rulesFired.add("Musuh memiliki regenerasi tinggi/lifesteal, direkomendasikan Venomous Staff untuk membatasi penyembuhan.");
        }
      }
    }

    // Rule: Anti-Tank / Pierce
    if (enemyTankCount >= 2) {
      if (primaryDamageType == "Physical") {
        if (hero.heroClass.contains(HeroClass.marksman)) {
          HokItem? pierce = _getItemByName("Daybreaker");
          if (pierce != null) {
            coreAndSituational.add(pierce);
            rulesFired.add("Musuh memiliki banyak Tank, direkomendasikan Daybreaker untuk Physical Pierce terbaik bagi Marksman.");
          }
        } else {
          HokItem? pierce = _getItemByName("Starbreaker");
          if (pierce != null) {
            coreAndSituational.add(pierce);
            rulesFired.add("Musuh memiliki banyak Tank, direkomendasikan Starbreaker untuk Physical Pierce.");
          }
        }
      } else {
        HokItem? pierce = _getItemByName("Void Staff");
        if (pierce != null) {
          coreAndSituational.add(pierce);
          rulesFired.add("Musuh memiliki banyak Tank, direkomendasikan Void Staff untuk Magic Pierce.");
        }
      }
    }

    // Rule: Defense against heavy Physical
    if (enemyPhysicalCount >= 3) {
      HokItem? physDef = _getItemByName("Ominous Premonition");
      if (physDef != null) {
        coreAndSituational.add(physDef);
        rulesFired.add("Musuh didominasi serangan Physical, direkomendasikan Ominous Premonition untuk slow dan defense.");
      }
      
      if (hero.heroClass.contains(HeroClass.tank) || hero.heroClass.contains(HeroClass.fighter)) {
        HokItem? spike = _getItemByName("Spikemail");
        if (spike != null) {
          coreAndSituational.add(spike);
          rulesFired.add("Menghadapi serangan physical masif, Spikemail direkomendasikan untuk memantulkan damage.");
        }
      }
    }

    // Rule: Defense against heavy Magical
    if (enemyMagicalCount >= 2) {
      HokItem? magDef = _getItemByName("Succubus Cloak");
      if (magDef != null) {
        coreAndSituational.add(magDef);
        rulesFired.add("Musuh memiliki significant Magic damage, direkomendasikan Succubus Cloak untuk magic shield.");
      }
    }

    // Class-specific Core Items (non-boots, non-jungling, non-roaming)
    if (primaryDamageType == "Physical") {
      if (hero.heroClass.contains(HeroClass.marksman)) {
        _addCoreToList(coreAndSituational, "Eternity Blade", "Eternity Blade meningkatkan Critical Damage utama Marksman.", rulesFired);
        _addCoreToList(coreAndSituational, "Shadow Ripper", "Shadow Ripper meningkatkan Attack Speed dan Critical Rate pasif Marksman.", rulesFired);
        _addCoreToList(coreAndSituational, "Doomsday", "Doomsday memberikan lifesteal dan persenan HP damage tambahan.", rulesFired);
        _addCoreToList(coreAndSituational, "Daybreaker", "Daybreaker direkomendasikan untuk menembus pertahanan musuh (Critical + Pierce).", rulesFired);
        _addCoreToList(coreAndSituational, "Master Sword", "Master Sword direkomendasikan untuk tambahan critical rate dan burst basic attack.", rulesFired);
      } else if (hero.heroClass.contains(HeroClass.assassin)) {
        _addCoreToList(coreAndSituational, "Axe of Torment", "Axe of Torment direkomendasikan untuk armor pierce early-game dan slow.", rulesFired);
        _addCoreToList(coreAndSituational, "Eternity Blade", "Eternity Blade meningkatkan critical damage untuk burst cepat.", rulesFired);
        _addCoreToList(coreAndSituational, "Siege Breaker", "Siege Breaker meningkatkan physical damage secara masif untuk menghabisi musuh HP rendah.", rulesFired);
        _addCoreToList(coreAndSituational, "Master Sword", "Master Sword memberikan tambahan burst damage setelah menggunakan skill.", rulesFired);
      } else {
        // Fighter / Tank
        _addCoreToList(coreAndSituational, "Axe of Torment", "Axe of Torment memberikan physical damage dan cooldown reduction bagi Fighter.", rulesFired);
        _addCoreToList(coreAndSituational, "Cuirass of Savagery", "Cuirass of Savagery direkomendasikan untuk keseimbangan defense, speed, dan damage bonus.", rulesFired);
        _addCoreToList(coreAndSituational, "Master Sword", "Master Sword memberikan damage tambahan setelah mengeluarkan skill.", rulesFired);
        _addCoreToList(coreAndSituational, "Pure Sky", "Pure Sky direkomendasikan untuk pengurangan damage aktif dan cooldown reduction.", rulesFired);
      }
    } else {
      // Magical Hero (Mages/Supports)
      _addCoreToList(coreAndSituational, "Savant’s Wrath", "Savant's Wrath meningkatkan Magic Attack secara masif untuk scaling damage.", rulesFired);
      _addCoreToList(coreAndSituational, "Scepter of Reverberation", "Scepter of Reverberation memicu ledakan area saat skill mengenai musuh.", rulesFired);
      _addCoreToList(coreAndSituational, "Mask of Agony", "Mask of Agony memberikan damage berkelanjutan berdasarkan persen HP musuh.", rulesFired);
      _addCoreToList(coreAndSituational, "Insatiable Tome", "Insatiable Tome memberikan Magic Lifesteal tinggi untuk sustain di lane.", rulesFired);
      
      if (hero.basic.maxMana > 0) {
        _addCoreToList(coreAndSituational, "Holy Grail", "Holy Grail direkomendasikan untuk regenerasi Mana dan Cooldown Reduction konstan.", rulesFired);
      }
      
      if (hero.heroClass.contains(HeroClass.support)) {
        _addCoreToList(coreAndSituational, "Frozen Breath", "Frozen Breath memberikan efek slow pada skill untuk membantu crowd control tim.", rulesFired);
      }
    }

    // Default Defensive / Utility Fallbacks
    if (hero.heroClass.contains(HeroClass.tank) || hero.heroClass.contains(HeroClass.support)) {
      _addCoreToList(coreAndSituational, "Longnight Guardian", "Longnight Guardian direkomendasikan untuk pertahanan burst damage late-game.", rulesFired);
      _addCoreToList(coreAndSituational, "Ominous Premonition", "Ominous Premonition direkomendasikan untuk physical defense tambahan.", rulesFired);
      _addCoreToList(coreAndSituational, "Succubus Cloak", "Succubus Cloak direkomendasikan untuk magic defense tambahan.", rulesFired);
      _addCoreToList(coreAndSituational, "Blazing Cape", "Blazing Cape direkomendasikan untuk damage bakar pasif di sekitar tank.", rulesFired);
    } else {
      if (primaryDamageType == "Physical") {
        _addCoreToList(coreAndSituational, "Destiny", "Destiny direkomendasikan di slot akhir untuk menghindari instant burst kill.", rulesFired);
      } else {
        _addCoreToList(coreAndSituational, "Splendor", "Splendor direkomendasikan di slot akhir untuk kebal sementara saat ditekan musuh.", rulesFired);
      }
    }

    // Filter out movement, jungling, or roaming items from situational list
    coreAndSituational = coreAndSituational.where((item) => 
      item.category != "Movement" && 
      item.category != "Jungling" && 
      item.category != "Roaming"
    ).toList();

    // Ensure uniqueness
    final uniqueItems = <HokItem>[];
    for (var item in coreAndSituational) {
      if (!uniqueItems.any((element) => element.name == item.name)) {
        uniqueItems.add(item);
      }
    }

    // Fill with fallback items from database if we don't have enough to fill the slots
    final allItemsList = _items.values.toList();
    for (var item in allItemsList) {
      if (uniqueItems.length >= 5) break; // we need at most 5 items for non-jungle, 4 for jungle/roam

      if (item.category == "Movement" || item.category == "Jungling" || item.category == "Roaming") {
        continue;
      }
      if (!uniqueItems.any((element) => element.name == item.name)) {
        uniqueItems.add(item);
        rulesFired.add("Item standar ${item.name} ditambahkan untuk melengkapi build.");
      }
    }

    // --- 4. CONSTRUCT FINAL BUILD LIST IN EXACT ORDER ---
    List<HokItem> finalBuild = [];

    if (isJungling && specialItem != null) {
      // Slot 1: Jungling Item
      finalBuild.add(specialItem);
      // Slot 2: Movement Item (Boots)
      if (movementItem != null) finalBuild.add(movementItem);
      // Slots 3-6: 4 Core/Situational Items
      finalBuild.addAll(uniqueItems.take(4));
    } else if (isRoaming && specialItem != null) {
      // Slot 1: Roaming Item
      finalBuild.add(specialItem);
      // Slot 2: Movement Item (Boots)
      if (movementItem != null) finalBuild.add(movementItem);
      // Slots 3-6: 4 Core/Situational Items
      finalBuild.addAll(uniqueItems.take(4));
    } else {
      // Slot 1: Movement Item (Boots)
      if (movementItem != null) finalBuild.add(movementItem);
      // Slots 2-6: 5 Core/Situational Items
      finalBuild.addAll(uniqueItems.take(5));
    }

    // Ensure the final build has exactly 6 items
    while (finalBuild.length < 6) {
      if (allItemsList.isEmpty) {
        finalBuild.add(HokItem(
          name: "Item Placeholder",
          category: "Physical",
          stats: {},
          passive: "Placeholder passive.",
          imageUrl: "",
        ));
        continue;
      }
      // Fallback in case finalBuild is less than 6
      final item = allItemsList.firstWhere(
        (i) => i.category != "Movement" && i.category != "Jungling" && i.category != "Roaming" && !finalBuild.any((f) => f.name == i.name),
        orElse: () => allItemsList.first
      );
      finalBuild.add(item);
      rulesFired.add("Item cadangan tambahan ${item.name} digunakan.");
    }

    // Slice to exactly 6 items
    if (finalBuild.length > 6) {
      finalBuild = finalBuild.sublist(0, 6);
    }

    return ItemRecommendationResult(items: finalBuild, firedRules: rulesFired);
  }

  HokItem? _getItemByName(String name) {
    final key = _items.keys.firstWhere(
      (k) => k.toLowerCase() == name.toLowerCase(), 
      orElse: () => ''
    );
    return key.isNotEmpty ? _items[key] : null;
  }

  void _addCoreToList(List<HokItem> list, String itemName, String ruleExplanation, List<String> rulesFired) {
    HokItem? item = _getItemByName(itemName);
    if (item != null && !list.any((element) => element.name == item.name)) {
      list.add(item);
      rulesFired.add(ruleExplanation);
    }
  }
}
