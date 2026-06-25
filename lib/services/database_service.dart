import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hero_model.dart';
import '../models/user_model.dart'; // Buat model ini
import '../models/career_model.dart'; // Buat model ini

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hoku.db');
    // PENTING: Jalankan pembuatan tabel tambahan setelah DB dibuka
    await _createExtraTables(_database!);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    if (await databaseExists(path)) {
      return await openDatabase(path);
    }

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

  // Fungsi untuk membuat tabel User dan Career jika belum ada di file assets
  Future<void> _createExtraTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT,
        nickname TEXT,
        uid TEXT,
        current_rank TEXT,
        highest_rank TEXT,
        peak_points TEXT,
        favorite_hero TEXT,
        favorite_lane TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS careers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        creator_id INTEGER,
        role TEXT,
        team TEXT,
        location TEXT,
        salary TEXT,
        requirements TEXT,
        created_at TEXT,
        FOREIGN KEY (creator_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }

  // --- FUNGSI HERO (Sama seperti sebelumnya) ---
  Future<List<Hero>> getAllHeroesWithRelations() async {
    final db = await instance.database;
    final heroMaps = await db.query('heroes');
    final relationMaps = await db.query('hero_relations');

    Map<String, Map<String, Partner>> bestPartners = {};
    Map<String, Map<String, Partner>> suppressingHeroes = {};
    Map<String, Map<String, Partner>> suppressedHeroes = {};

    for (var rel in relationMaps) {
      String heroId = rel['hero_id'] as String;
      String type = rel['relation_type'] as String;
      Partner partner = Partner.fromMap(rel);
      if (type == 'bestPartner')
        bestPartners.putIfAbsent(heroId, () => {})[partner.name] = partner;
      if (type == 'suppressingHero')
        suppressingHeroes.putIfAbsent(heroId, () => {})[partner.name] = partner;
      if (type == 'suppressedHero')
        suppressedHeroes.putIfAbsent(heroId, () => {})[partner.name] = partner;
    }

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

  // --- FUNGSI USER & AUTH ---
  // Cek apakah Email/IGN/UID sudah terdaftar
  Future<String?> checkUniqueness(
    String email,
    String nickname,
    String uid,
  ) async {
    final db = await instance.database;

    var resEmail = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (resEmail.isNotEmpty) return "Email sudah digunakan";

    var resNick = await db.query(
      'users',
      where: 'nickname = ?',
      whereArgs: [nickname],
    );
    if (resNick.isNotEmpty) return "Nickname sudah digunakan";

    var resUid = await db.query('users', where: 'uid = ?', whereArgs: [uid]);
    if (resUid.isNotEmpty) return "UID sudah digunakan";

    return null; // Semua unik
  }

  // Login: Bisa pake Email atau Nickname atau UID
  Future<UserModel?> loginUser(String identifier, String password) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> res = await db.query(
      'users',
      where: '(email = ? OR nickname = ? OR uid = ?) AND password = ?',
      whereArgs: [identifier, identifier, identifier, password],
    );

    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }
    return null;
  }

  Future<int> registerUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  // --- SESSION MANAGEMENT ---
  static const String _userKey = "logged_user_id";

  Future<void> saveSession(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userKey, id);
  }

  Future<int?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userKey);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // --- USER CRUD ---
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    // Hapus karir user dulu (atau biarkan ON DELETE CASCADE bekerja)
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePassword(int id, String newPass) async {
    final db = await instance.database;
    return await db.update(
      'users',
      {'password': newPass},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Tambahkan pengecekan email unik khusus untuk update (mengabaikan email milik sendiri)
  Future<bool> isEmailUniqueForUpdate(
    int currentUserId,
    String newEmail,
  ) async {
    final db = await instance.database;
    var res = await db.query(
      'users',
      where: 'email = ? AND id != ?',
      whereArgs: [newEmail, currentUserId],
    );
    return res.isEmpty;
  }

  // Update fungsi updateProfile agar lebih fleksibel
  Future<int> updateProfile(int id, Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.update('users', data, where: 'id = ?', whereArgs: [id]);
  }

  // --- FUNGSI CAREER ---
  Future<int> insertCareer(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('careers', data);
  }

  Future<List<Map<String, dynamic>>> getCareers() async {
    final db = await instance.database;
    // Gunakan JOIN untuk mendapatkan nickname pembuat post
    return await db.rawQuery('''
      SELECT careers.*, users.nickname as creator_name 
      FROM careers 
      JOIN users ON careers.creator_id = users.id 
      ORDER BY careers.id DESC
    ''');
  }

  Future<int> updateCareer(int id, Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.update('careers', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCareer(int id) async {
    final db = await instance.database;
    return await db.delete('careers', where: 'id = ?', whereArgs: [id]);
  }
}
