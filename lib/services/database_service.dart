import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/hero_model.dart'; // Pastikan path ini benar

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hoku.db');
    return _database!;
  }

  // Fungsi untuk meng-copy DB dari aset ke direktori aplikasi
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Cek apakah database sudah ada
    if (await databaseExists(path)) {
      return await openDatabase(path);
    }

    // Jika belum, copy dari aset
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join('assets/database', filePath));
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path);
  }

  // Fungsi utama untuk mengambil semua data hero beserta relasinya
  Future<List<Hero>> getAllHeroesWithRelations() async {
    final db = await instance.database;

    // 1. Ambil semua data dari tabel heroes
    final heroMaps = await db.query('heroes');

    // 2. Ambil semua data dari tabel relasi
    final relationMaps = await db.query('hero_relations');

    // 3. Proses data relasi ke dalam format yang mudah diakses
    Map<String, Map<String, Partner>> bestPartners = {};
    Map<String, Map<String, Partner>> suppressingHeroes = {};
    Map<String, Map<String, Partner>> suppressedHeroes = {};

    for (var rel in relationMaps) {
      String heroId = rel['hero_id'] as String;
      String type = rel['relation_type'] as String;
      Partner partner = Partner.fromMap(rel);

      switch (type) {
        case 'bestPartner':
          bestPartners.putIfAbsent(heroId, () => {})[partner.name] = partner;
          break;
        case 'suppressingHero':
          suppressingHeroes.putIfAbsent(heroId, () => {})[partner.name] =
              partner;
          break;
        case 'suppressedHero':
          suppressedHeroes.putIfAbsent(heroId, () => {})[partner.name] =
              partner;
          break;
      }
    }

    // 4. Gabungkan data hero dengan relasinya menjadi objek Hero
    return heroMaps.map((heroMap) {
      final heroId = heroMap['id'] as String;
      return Hero.fromMap(
        heroMap,
        bestPartners[heroId] ?? {},
        suppressingHeroes[heroId] ?? {},
        suppressedHeroes[heroId] ?? {},
      );
    }).toList();
  }
}
