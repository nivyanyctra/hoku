#!/usr/bin/env dart

/// HoK Hero Database Generator Pipeline (Dart Version)
///
/// Cara menjalankan:
///   1. Buka terminal di root project Flutter
///   2. Jalankan: dart run tool/generate_hero_db.dart
///   3. File heroes.db akan dibuat di root project
///   4. Pindahkan heroes.db ke assets/database/
///
/// Struktur project:
///   lib/
///     models/hero.dart  ← Class definitions & enums
///     data/hero.dart    ← List heroes (data dasar)
///   api.json            ← Data lengkap dari API
///   tool/
///     generate_hero_db.dart  ← Script ini

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:translator/translator.dart';
import 'package:path/path.dart' as p;

// ═══════════════════════════════════════════════════════
// IMPORT DARI PROJECT FLUTTER KAMU
// ═══════════════════════════════════════════════════════
import '../lib/models/hero.dart';
import '../lib/data/hero.dart';

// ═══════════════════════════════════════════════════════
// KONFIGURASI
// ═══════════════════════════════════════════════════════
const String apiJsonPath = 'api.json';
const String dbOutputPath = 'heroes.db';
const int rateLimitSeconds = 2;
const bool enableScraping =
    true; // Set false jika Liquipedia tidak bisa diakses
const bool enableTranslation = true;

final translator = GoogleTranslator();

// ═══════════════════════════════════════════════════════
// GLOBAL → CN HERO MAPPING
// ═══════════════════════════════════════════════════════
const Map<String, String> globalToCn = {
  'agudo': '阿古朵', 'angela': '安琪拉', 'aoyin': '敖隐','arke': '阿轲', 'arthur': '亚瑟',
  'ata': '猪八戒', 'athena': '雅典娜', 'baiqi': '白起', 'caiyan': '蔡文姬',
  'charlotte': '夏洛特','chano' : '苍', 'chicha': '蚩奼', 'consortyu': '虞姬', 'daqiao': '大乔',
  'daji': '妲己', 'dharma': '达摩', 'direnjie': '狄仁杰', 'dianwei': '典韦',
  'diaochan': '貂蝉', 'dolia': '朵莉亚', 'donghuang': '东皇太一', 'drbian': '扁鹊',
  'dun': '盾山', 'erin': '艾琳', 'fatih' : '曹操', 'feyd' : '暃',
  'flowborn(mage)': '元流之子(法师)',
  'flowborn(marksman)': '元流之子(射手)',
  'flowborn(tank)': '元流之子(坦克)',
  'fuzi': '老夫子', 'ganmo': '干将莫邪', 'gao': '高渐离',
  'gaochanggong': '兰陵王', 'garuda': '嬴政', 'guanyu': '关羽', 'guiguzi': '鬼谷子',
  'hanxin': '韩信', 'heino': '海诺', 'houyi': '后羿', 'huangzhong': '黄忠',
  'jing': '镜', 'kaizer': '铠', 'kongming': '诸葛亮', 'kui': '钟馗',
  'ladysun': '孙尚香', 'ladyzhen': '甄姬', 'lam': '澜','lapulapu' : '牛魔', 'libai': '李白',
  'lixin': '李信', 'lianpo': '廉颇', 'liang': '张良', 'liubang': '刘邦',
  'liubei': '刘备', 'liushan': '刘禅', 'lubu': '吕布', 'lubanno7': '鲁班七号',
  'luna': '露娜', 'maishiranui': '不知火舞', 'marcopolo': '马可波罗',
  'mengya': '蒙犽', 'menki': '梦奇', 'miyue': '芈月', 'milady': '米莱狄',
  'ming': '明世隐', 'mozi': '墨子', 'mulan': '花木兰', 'musashi': '宫本武藏',
  'nakoruru': '娜可露露', 'nezha': '哪吒', 'nuwa': '女娲', 'pei': '裴擒虎',
  'shangguan': '上官婉儿', 'shoyue': '沈梦溪', 'simayi': '司马懿', 'sunbin': '孙膑',
  'sunce': '孙策', 'ukyotachibana': '橘右京', 'umbrosa' : '影', 'wangzhaojun': '王昭君',
  'wukong': '孙悟空', 'wuyan': '钟无艳', 'xiangyu': '项羽', 'xiaoqiao': '小乔',
  'yangjian': '杨戬', 'yango' : '元歌', 'yaria': '瑶', 'ying': '影', 'yixing': '弈星',
  'yuhuan': '杨玉环', 'zhangfei': '张飞', 'zhouyu': '周瑜', 'zhuangzi': '庄周',
  'zilong': '赵云', 'ziya': '姜子牙',
  'alessio': '莱西奥', 'allain': '亚连', 'arli': '公孙离', 'augran': '大司命',
  'biron': '狂铁', 'cirrus': '云中君', 'dyadia': '少司缘',
  'fang': '李元芳', 'garo': '伽罗', 'haya': '海月', 'mayene': '姬小满',
  'sakeer': '桑启', 'shi': '西施', 'xuance': '百里玄策', 'yao': '曜',
  // AOV
  'butterfly': '刀锋宝贝', 'luara' : '卢雅那',
};

// ═══════════════════════════════════════════════════════
// DATABASE SCHEMA
// ═══════════════════════════════════════════════════════
const String schema = '''
CREATE TABLE IF NOT EXISTS heroes (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    name_cn TEXT,
    title TEXT,
    image_asset TEXT,
    hero_class TEXT,
    sub_hero_class TEXT,
    core_abilities TEXT,
    recommended_lane TEXT,
    team_fight_position TEXT,
    golem_type TEXT,
    golem_level TEXT,
    peak_periods TEXT,
    difficulty TEXT,
    survival_pct INTEGER DEFAULT 0,
    attack_pct INTEGER DEFAULT 0,
    ability_pct INTEGER DEFAULT 0,
    difficulty_pct INTEGER DEFAULT 0,
    max_health INTEGER DEFAULT 0,
    max_mana INTEGER DEFAULT 0,
    physical_attack INTEGER DEFAULT 0,
    magical_attack INTEGER DEFAULT 0,
    physical_defense INTEGER DEFAULT 0,
    magical_defense INTEGER DEFAULT 0,
    movement_speed INTEGER DEFAULT 0,
    physical_pierce INTEGER DEFAULT 0,
    magical_pierce INTEGER DEFAULT 0,
    attack_speed_bonus REAL DEFAULT 0,
    critical_rate REAL DEFAULT 0,
    critical_damage REAL DEFAULT 0,
    physical_lifesteal REAL DEFAULT 0,
    magical_lifesteal REAL DEFAULT 0,
    cooldown_reduction REAL DEFAULT 0,
    attack_range TEXT,
    resistance REAL DEFAULT 0,
    health_per5s INTEGER DEFAULT 0,
    mana_per5s INTEGER DEFAULT 0,
    scraped_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_source TEXT DEFAULT 'api_json'
);

CREATE TABLE IF NOT EXISTS skills (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hero_id TEXT NOT NULL,
    skill_num INTEGER NOT NULL,
    name TEXT,
    name_cn TEXT,
    type TEXT,
    ability_type TEXT,
    damage_type TEXT,
    cooldown TEXT,
    cost TEXT,
    description TEXT,
    description_cn TEXT,
    image_url TEXT,
    FOREIGN KEY (hero_id) REFERENCES heroes(id),
    UNIQUE(hero_id, skill_num)
);

CREATE TABLE IF NOT EXISTS skins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hero_id TEXT NOT NULL,
    name TEXT,
    name_cn TEXT,
    rarity TEXT DEFAULT 'classic',
    image_url TEXT,
    FOREIGN KEY (hero_id) REFERENCES heroes(id)
);

CREATE TABLE IF NOT EXISTS hero_relations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hero_id TEXT NOT NULL,
    relation_type TEXT NOT NULL,
    target_hero_id TEXT,
    target_name TEXT,
    target_name_cn TEXT,
    thumbnail TEXT,
    description TEXT,
    description_cn TEXT,
    FOREIGN KEY (hero_id) REFERENCES heroes(id)
);
''';

// ═══════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════
int pctToInt(dynamic value) {
  if (value == null) return 0;
  final str = value.toString();
  final match = RegExp(r'(\d+)').firstMatch(str);
  return match != null ? int.parse(match.group(1)!) : 0;
}

Future<String> translateCn(String text) async {
  if (!enableTranslation || text.isEmpty) return text;
  if (!RegExp(r'[\u4e00-\u9fff]').hasMatch(text)) return text;
  try {
    final result = await translator.translate(text, from: 'zh-CN', to: 'en');
    return result.text;
  } catch (e) {
    print('  ⚠ Translation failed: $e');
    return text;
  }
}

Future<Map<String, dynamic>> loadApiData() async {
  final file = File(apiJsonPath);
  if (!await file.exists()) {
    throw 'File $apiJsonPath tidak ditemukan!';
  }
  final jsonString = await file.readAsString();
  final decoded = jsonDecode(jsonString);
  return decoded['main'] as Map<String, dynamic>;
}

String? cnNameToGlobalId(String cnName) {
  for (final entry in globalToCn.entries) {
    if (entry.value == cnName) return entry.key;
  }
  return null;
}

// ═══════════════════════════════════════════════════════
// LIQUIPEDIA SCRAPER
// ═══════════════════════════════════════════════════════
Future<Map<String, dynamic>?> scrapeLiquipedia(
  String heroId,
  String heroName,
) async {
  if (!enableScraping) return null;

  final slug = heroName.replaceAll(' ', '_').replaceAll("'", '%27');
  final url = 'https://liquipedia.net/honorofkings/$slug';

  try {
    final response = await http
        .get(
          Uri.parse(url),
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0',
          },
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      print('  ⚠ HTTP ${response.statusCode} from Liquipedia');
      return null;
    }

    final document = html_parser.parse(response.body);
    final data = <String, dynamic>{
      'hero_id': heroId,
      'hero_name': heroName,
      'liquipedia_url': url,
    };

    // Title
    final titleEl = document.querySelector('.infobox-header-2');
    data['title'] = titleEl?.text.trim();

    await Future.delayed(Duration(seconds: rateLimitSeconds));
    return data;
  } catch (e) {
    print('  ⚠ Scraping error: $e');
    return null;
  }
}

// ═══════════════════════════════════════════════════════
// POPULATE HERO
// ═══════════════════════════════════════════════════════
Future<void> populateHero(
  Database db,
  Hero hero,
  Map<String, dynamic> apiData,
) async {
  final heroId = hero.id;
  final heroName = hero.name;
  final cnName = globalToCn[heroId];
  final apiHero = cnName != null ? apiData[cnName] : null;

  Map<String, dynamic>? liqData;
  if (enableScraping) {
    liqData = await scrapeLiquipedia(heroId, heroName);
  }

  // ── Title ──
  String? title;
  if (liqData != null && liqData['title'] != null) {
    title = liqData['title'];
  } else if (apiHero != null) {
    final cnTitle = apiHero['title']?.toString() ?? '';
    title = cnTitle.isNotEmpty ? await translateCn(cnTitle) : cnTitle;
  }

  // ── Percentages from api.json ──
  final survivalPct = apiHero != null
      ? pctToInt(apiHero['survivalPercentage'])
      : 0;
  final attackPct = apiHero != null ? pctToInt(apiHero['attackPercentage']) : 0;
  final abilityPct = apiHero != null
      ? pctToInt(apiHero['abilityPercentage'])
      : 0;
  final difficultyPct = apiHero != null
      ? pctToInt(apiHero['difficultyPercentage'])
      : 0;

  // ── Insert Hero ──
  await db.insert('heroes', {
    'id': heroId,
    'name': heroName,
    'name_cn': cnName,
    'title': title,
    'image_asset': hero.imageAsset,
    'hero_class': jsonEncode(hero.heroClass.map((e) => e.name).toList()),
    'sub_hero_class': hero.subHeroClass,
    'core_abilities': hero.coreAbilities,
    'recommended_lane': hero.recommendedLane.name,
    'team_fight_position': hero.teamFightPosition.name,
    'golem_type': hero.golemDependency.type.name,
    'golem_level': hero.golemDependency.level.name,
    'peak_periods': hero.peakPeriods.name,
    'difficulty': hero.difficulty.name,
    'survival_pct': survivalPct,
    'attack_pct': attackPct,
    'ability_pct': abilityPct,
    'difficulty_pct': difficultyPct,
    'max_health': hero.basic.maxHealth,
    'max_mana': hero.basic.maxMana,
    'physical_attack': hero.basic.physicalAttack,
    'magical_attack': hero.basic.magicalAttack,
    'physical_defense': hero.basic.physicalDefense,
    'magical_defense': hero.basic.magicalDefense,
    'movement_speed': hero.offensive.movementSpeed.toInt(),
    'physical_pierce': hero.offensive.physicalPierce,
    'magical_pierce': hero.offensive.magicalPierce,
    'attack_speed_bonus': hero.offensive.attackSpeedBonus,
    'critical_rate': hero.offensive.criticalRate,
    'critical_damage': hero.offensive.criticalDamage,
    'physical_lifesteal': hero.offensive.physicalLifesteal,
    'magical_lifesteal': hero.offensive.magicalLifesteal,
    'cooldown_reduction': hero.offensive.cooldownReduction,
    'attack_range': hero.offensive.attackRange.name,
    'resistance': hero.defensive.resistance,
    'health_per5s': hero.defensive.healthPer5s,
    'mana_per5s': hero.defensive.manaPer5s,
    'data_source': liqData != null
        ? 'liquipedia+api_json'
        : 'api_json+hero_dart',
  }, conflictAlgorithm: ConflictAlgorithm.replace);

  // ── Skills from api.json ──
  if (apiHero != null) {
    final apiSkills = (apiHero['skill'] as List?) ?? [];

    for (var i = 0; i < apiSkills.length; i++) {
      final apiSkill = apiSkills[i] as Map<String, dynamic>;

      final skillNameCn = apiSkill['skillName']?.toString() ?? '';
      final skillNameEn = await translateCn(skillNameCn);

      final skillDescCn = apiSkill['skillDesc']?.toString() ?? '';
      final skillDescEn = await translateCn(skillDescCn);

      // Determine skill type (first skill is usually passive)
      final skillType = i == 0 ? 'passive' : 'active';

      await db.insert('skills', {
        'hero_id': heroId,
        'skill_num': i,
        'name': skillNameEn,
        'name_cn': skillNameCn,
        'type': skillType,
        'ability_type': jsonEncode([]),
        'damage_type': null,
        'cooldown': jsonEncode(apiSkill['cooldown'] ?? [0]),
        'cost': jsonEncode(apiSkill['cost'] ?? [0]),
        'description': skillDescEn,
        'description_cn': skillDescCn,
        'image_url': apiSkill['skillImg'],
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // ── Skins from api.json ──
  if (apiHero != null) {
    await db.delete('skins', where: 'hero_id = ?', whereArgs: [heroId]);
    final apiSkins = (apiHero['skins'] as List?) ?? [];

    for (var j = 0; j < apiSkins.length; j++) {
      final apiSkin = apiSkins[j] as Map<String, dynamic>;

      final skinNameCn = apiSkin['skinName']?.toString() ?? '';
      final skinNameEn = await translateCn(skinNameCn);

      var rawUrl = apiSkin['skinImg']?.toString() ?? '';
      rawUrl = rawUrl.replaceAll('https:https://', 'https://');

      // Rarity: first skin = classic, others = epic (default)
      final rarity = j == 0 ? 'classic' : 'epic';

      await db.insert('skins', {
        'hero_id': heroId,
        'name': skinNameEn,
        'name_cn': skinNameCn,
        'rarity': rarity,
        'image_url': rawUrl,
      });
    }
  }

  // ── Hero Relations from api.json ──
  if (apiHero != null) {
    await db.delete(
      'hero_relations',
      where: 'hero_id = ?',
      whereArgs: [heroId],
    );
    final relationFields = {
      'bestPartners': 'bestPartner',
      'suppressingHeroes': 'suppressingHero',
      'suppressedHeroes': 'suppressedHero',
    };

    for (final entry in relationFields.entries) {
      final relations = apiHero[entry.key] as Map<String, dynamic>? ?? {};
      for (final rel in relations.entries) {
        final targetCnName = rel.key;
        final relData = rel.value as Map<String, dynamic>;
        final targetGlobalId = cnNameToGlobalId(targetCnName);

        final descCn = relData['description']?.toString() ?? '';
        final descEn = await translateCn(descCn);

        // Cari nama global dari heroes list
        String? targetName;
        if (targetGlobalId != null) {
          try {
            final match = heroes.firstWhere((h) => h.id == targetGlobalId);
            targetName = match.name;
          } catch (_) {}
        }
        targetName ??= targetCnName;

        await db.insert('hero_relations', {
          'hero_id': heroId,
          'relation_type': entry.value,
          'target_hero_id': targetGlobalId,
          'target_name': targetName,
          'target_name_cn': targetCnName,
          'thumbnail': relData['thumbnail'],
          'description': descEn,
          'description_cn': descCn,
        });
      }
    }
  }

  print('  ✓ [$heroId] $heroName → ${cnName ?? "no CN mapping"}');
}

// ═══════════════════════════════════════════════════════
// MAIN
// ═══════════════════════════════════════════════════════
Future<void> main() async {
  print('📍 Working directory: ${Directory.current.path}');
  print('═══════════════════════════════════════════════');
  print('  HoK Hero Database Generator (Dart CLI)');
  print('═══════════════════════════════════════════════\n');

  // Init FFI untuk SQLite (wajib di desktop)
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  // Hapus DB lama jika ada
  final dbFile = File(dbOutputPath);
  if (await dbFile.exists()) {
    await dbFile.delete();
    print('🗑  DB lama dihapus');
  }

  // Buka DB baru
  final db = await databaseFactory.openDatabase(
    dbOutputPath,
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, v) async {
        for (final statement in schema.split(';')) {
          final trimmed = statement.trim();
          if (trimmed.isNotEmpty) {
            await db.execute(trimmed);
          }
        }
      },
    ),
  );

  print('📂 Database dibuat: $dbOutputPath\n');

  // Load API data
  print('📥 Loading api.json...');
  final apiData = await loadApiData();
  print('   ✓ ${apiData.length} heroes di api.json\n');

  // Process heroes
  print('🎮 Processing ${heroes.length} heroes dari data/hero.dart...\n');
  var success = 0, failed = 0;

  for (final hero in heroes) {
    try {
      await populateHero(db, hero, apiData);
      success++;
    } catch (e) {
      print('  ✗ [${hero.id}] Failed: $e');
      failed++;
    }
  }

  // Summary
  print('\n═══════════════════════════════════════════════');
  print('  ✅ DONE');
  print('═══════════════════════════════════════════════');
  print('Success: $success | Failed: $failed');

  // Helper untuk ambil nilai COUNT dari query
  Future<int> getCount(String tableName) async {
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName',
    );
    return (result.first['count'] as int?) ?? 0;
  }

  final heroCount = await getCount('heroes');
  final skillCount = await getCount('skills');
  final skinCount = await getCount('skins');
  final relCount = await getCount('hero_relations');
  print('Heroes: $heroCount');
  print('Skills: $skillCount');
  print('Skins: $skinCount');
  print('Relations: $relCount');
  print('\n📁 File tersimpan di: ${p.absolute(dbOutputPath)}');
  print('💡 Pindahkan file ini ke: assets/database/heroes.db');

  await db.close();
}
