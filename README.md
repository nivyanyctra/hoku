# HOKU

Aplikasi mobile berbasis Flutter yang dirancang sebagai *companion app* untuk game **Honor of Kings**. HOKU membantu pemain meningkatkan performa mereka melalui fitur draft simulator cerdas, rekomendasi item otomatis, dan informasi pertandingan esports terkini.

---

## Fitur Utama

### Draft Simulator
Simulasi proses pick & ban layaknya pertandingan profesional. Pilih hero musuh dan tim kamu, lalu biarkan AI menganalisis situasi draf secara real-time.

- **AI berbasis Fuzzy Logic Metode Sugeno** merekomendasikan hero terbaik berdasarkan 8 kriteria:
  - Ketersediaan lane
  - Kebutuhan jungler
  - Kebutuhan frontline
  - Counter crowd control
  - Keseimbangan tipe damage (Physical vs Magical)
  - Fase permainan (early/late game)
  - Sinergi antar hero
  - Counter terhadap hero musuh
- Setiap rekomendasi disertai alasan yang jelas dan spesifik

### Rekomendasi Item
Setelah draft selesai, pilih hero kamu dan sistem akan membuatkan build item yang optimal secara otomatis.

- Engine berbasis **Forward-Chaining (Rule-Based)**
- Menghasilkan 6 item per build
- Mempertimbangkan lane, tipe hero, komposisi musuh (CC, tank, heal, physical/magical)
- Urutan item disesuaikan dimana sepatu di slot yang benar, item jungling/roaming di awal

### Jadwal Pertandingan (Leagues)
Menampilkan jadwal dan hasil pertandingan esports Honor of Kings secara langsung.

- Terhubung ke **PandaScore API** untuk data pertandingan terkini
- Menampilkan pertandingan 7 hari ke belakang hingga 28 hari ke depan

### Profil & Karir
- Buat profil pemain dengan rank, hero favorit, dan lane favorit
- **Fitur Karir** pemain bisa memposting atau mencari lowongan tim esports
- Manajemen akun lengkap (login, register, edit profil, hapus akun)

---

## Teknologi yang Digunakan

| Teknologi | Kegunaan |
|---|---|
| **Flutter** | Framework utama |
| **SQLite (sqflite)** | Database lokal untuk hero, user, dan karir |
| **SharedPreferences** | Manajemen sesi login |
| **PandaScore API** | Data pertandingan esports |
| **Fuzzy Logic Sugeno** | AI rekomendasi hero di draft simulator |
| **Forward-Chaining** | Engine rekomendasi item |

---

## Struktur Proyek

```
lib/
├── config/         # Konfigurasi API (token, endpoint)
├── models/         # Model data (Hero, User, Career, Match)
├── screens/
│   ├── auth/       # Login & Register
│   ├── home/       # Halaman utama
│   ├── academy/    # Draft simulator & rekomendasi item
│   ├── leagues/    # Jadwal pertandingan
│   ├── career/     # Lowongan tim esports
│   └── profile/    # Profil pengguna
├── services/
│   ├── database_service.dart          # Akses SQLite & sesi
│   ├── fuzzy_draft_services.dart      # AI fuzzy logic untuk draf
│   ├── item_recommendation_service.dart # Engine rekomendasi item
│   └── pandascore_service.dart        # Integrasi PandaScore API
├── theme/          # Tema dan styling global
├── utils/          # Fungsi bantuan
└── main.dart       # Entry point

assets/
├── database/
│   ├── hoku.db     # Database SQLite (data hero)
│   └── items.json  # Data item lengkap
└── icon/           # Ikon hero, class, dan lane
```

---

## Cara Menjalankan

### Download via Release (Cara Termudah)

1. Buka halaman [Releases](https://github.com/nivyanyctra/hoku/releases)
2. Pilih versi terbaru
3. Download file `.apk` (Android)
4. Install APK di HP pastikan **"Install dari sumber tidak dikenal"** sudah diaktifkan di pengaturan

### Build dari Source (Developer)

#### Prasyarat
- Flutter SDK `^3.11.1`
- Dart `^3.x`
- Perangkat Android/iOS atau emulator

#### Langkah-langkah

1. **Clone repository**
   ```bash
   git clone https://github.com/nivyanyctra/hoku.git
   cd hoku
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Konfigurasi API Key**

   Buka atau buat file `lib/config/api_config.dart` dan isi token PandaScore kamu:
   ```dart
   class ApiConfig {
     static const String pandaScoreToken = 'ISI_TOKEN_KAMU_DI_SINI';
   }
   ```

4. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

---

## Cara Kerja AI Draft Simulator

Sistem fuzzy logic bekerja dalam 3 tahap:

1. **Fuzzifikasi**: Menganalisis kondisi draf saat ini: survival tim, mobilitas musuh, lane yang kosong, keseimbangan damage, dan tekanan early game.

2. **Evaluasi Aturan**: Setiap hero yang tersedia diberi skor berdasarkan 8 aturan (kriteria), menghasilkan nilai keanggotaan (μ) antara 0.0–1.0.

3. **Defuzzifikasi (Sugeno Weighted Average)**: Skor akhir dihitung dari rata-rata tertimbang semua aturan. Hero dengan skor tertinggi direkomendasikan beserta alasannya.

---

## Cara Kerja Rekomendasi Item

Engine berbasis aturan (forward-chaining) memilih item secara bertahap:

1. **Sepatu**: Dipilih berdasarkan jumlah CC musuh, tipe damage hero, dan kelas hero.
2. **Item khusus**: Item jungling atau roaming dipilih jika relevan dengan lane.
3. **Item inti & situasional**: Dipilih berdasarkan kondisi musuh (banyak tank, heal, physical/magical) dan kelas hero.
4. **Finalisasi**: Build disesuaikan agar selalu menghasilkan tepat 6 item.

---

## Lisensi

Proyek ini dibuat untuk keperluan pembelajaran dan portofolio. Data hero dan item mengacu pada game Honor of Kings milik TiMi Studio / Tencent.
