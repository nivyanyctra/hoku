import 'package:flutter/material.dart' hide Hero;
import '../../models/hero_model.dart';
import '../../services/database_service.dart';
import '../../services/fuzzy_draft_services.dart';
import '../../services/item_recommendation_service.dart';

class AcademyPage extends StatefulWidget {
  const AcademyPage({super.key});

  @override
  State<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Hero>> _heroesFuture;
  List<Hero> _allHeroes = [];

  List<String?> blueBans = List.filled(3, null);
  List<String?> redBans = List.filled(3, null);
  List<Hero> bluePicks = [];
  List<Hero> redPicks = [];

  bool isBanPhase = true;
  String banSide = "blue"; // Mulai dari biru
  int banStep = 0; // Index 0, 1, 2

  String categoryMode = "Class"; // Switcher Class/Lane
  dynamic selectedFilter = "All";

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  Hero? selectedHeroForRec;

  @override
  void initState() {
    super.initState();
    _heroesFuture = _loadData();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(_glowController);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  Future<List<Hero>> _loadData() async {
    final heroes = await DatabaseService.instance.getAllHeroesWithRelations();
    await ItemRecommendationService.instance.loadItems();
    setState(() => _allHeroes = heroes);
    return heroes;
  }

  void _reset() {
    setState(() {
      blueBans = List.filled(3, null);
      redBans = List.filled(3, null);
      bluePicks.clear();
      redPicks.clear();
      isBanPhase = true;
      banSide = "blue";
      banStep = 0;
      selectedHeroForRec = null;
    });
  }

  int get totalPicked => bluePicks.length + redPicks.length;
  bool get isBlueTurn => [0, 3, 4, 7, 8].contains(totalPicked);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "HOKU DRAFT SIMULATOR",
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.redAccent),
            onPressed: _reset,
          ),
        ],
      ),
      body: FutureBuilder<List<Hero>>(
        future: _heroesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          // AI Helper Logic (Fuzzy Draft)
          final bannedIds = {
            ...blueBans,
            ...redBans,
          }.whereType<String>().toSet();
          final pickedIds = {
            ...bluePicks.map((e) => e.id),
            ...redPicks.map((e) => e.id),
          };
          final availableHeroes = _allHeroes
              .where((h) => !bannedIds.contains(h.id) && !pickedIds.contains(h.id))
              .toList();

          final fuzzyService = FuzzyDraftService(allHeroes: _allHeroes);
          var recs = isBanPhase || totalPicked >= 10
              ? <RecommendationResult>[]
              : fuzzyService.recommendHeroesFuzzy(
                  enemyPicks: isBlueTurn ? redPicks : bluePicks,
                  allyPicks: isBlueTurn ? bluePicks : redPicks,
                  availableHeroes: availableHeroes,
                );

          // Account for CurvedNavigationBar height (extendBody: true)
          final navBarPadding = MediaQuery.of(context).padding.bottom + 30;
          final isFinished = totalPicked >= 10;

          return Column(
            children: [
              _buildBanHeader(),
              Expanded(
                child: Row(
                  children: [
                    _buildPickSide(bluePicks, "BLUE TEAM", Colors.blue, true),
                    isFinished 
                        ? _buildAnalysisPanel()
                        : _buildHeroPool(),
                    _buildPickSide(redPicks, "RED TEAM", Colors.red, false),
                  ],
                ),
              ),
              if (isBanPhase) _buildBanControlInfo(),
              if (!isBanPhase && !isFinished) _buildAIHelper(recs),
              if (isFinished) _buildFinishedBar(),
              SizedBox(height: navBarPadding),
            ],
          );
        },
      ),
    );
  }

  // Header Ban: 3 Biru & 3 Merah
  Widget _buildBanHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _banGroup(blueBans, "blue", Colors.blue),
          const Text(
            "PHASE BAN",
            style: TextStyle(color: Colors.white24, fontSize: 9),
          ),
          _banGroup(redBans, "red", Colors.red),
        ],
      ),
    );
  }

  Widget _banGroup(List<String?> bans, String side, Color color) {
    return Row(
      children: List.generate(3, (i) {
        bool isActive = isBanPhase && banSide == side && banStep == i;
        Hero? h = (bans[i] != null)
            ? _allHeroes.firstWhere((e) => e.id == bans[i])
            : null;

        return AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white10,
                border: Border.all(
                  color: isActive
                      ? color.withValues(alpha: _glowAnimation.value)
                      : Colors.white24,
                  width: isActive ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
                image: h != null
                    ? DecorationImage(
                        image: NetworkImage(h.imageAsset),
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Colors.black54,
                          BlendMode.darken,
                        ),
                      )
                    : null,
              ),
              child: h == null && isActive
                  ? Icon(Icons.block, size: 18, color: color)
                  : null,
            );
          },
        );
      }),
    );
  }

  // Kolom Pick Samping
  Widget _buildPickSide(
    List<Hero> picks,
    String title,
    Color color,
    bool isLeft,
  ) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...List.generate(5, (i) {
            bool isActiveSlot =
                !isBanPhase &&
                totalPicked < 10 &&
                ((isBlueTurn && isLeft && i == bluePicks.length) ||
                    (!isBlueTurn && !isLeft && i == redPicks.length));
            Hero? h = i < picks.length ? picks[i] : null;

            return Expanded(
              child: AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  bool isSelectedForRec = (totalPicked >= 10) && selectedHeroForRec == h;
                  return GestureDetector(
                    onTap: (h != null && totalPicked >= 10)
                        ? () {
                            setState(() {
                              selectedHeroForRec = h;
                            });
                          }
                        : null,
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.03),
                        border: Border.all(
                          color: isSelectedForRec
                              ? const Color(0xFFC9A227)
                              : isActiveSlot
                                  ? color.withValues(alpha: _glowAnimation.value)
                                  : Colors.white12,
                          width: isSelectedForRec ? 2.5 : (isActiveSlot ? 2 : 1),
                        ),
                        boxShadow: isSelectedForRec
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFC9A227).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                )
                              ]
                            : null,
                        image: h != null
                            ? DecorationImage(
                                image: NetworkImage(h.imageAsset),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: h == null
                          ? Center(
                              child: Icon(
                                isActiveSlot ? Icons.add : Icons.person,
                                size: 16,
                                color: Colors.white10,
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  // Daftar Hero Tengah
  Widget _buildHeroPool() {
    List<Hero> displayed = _allHeroes.where((h) {
      if (selectedFilter == "All") return true;
      if (categoryMode == "Class") return h.heroClass.contains(selectedFilter);
      if (categoryMode == "Lane") return h.recommendedLane == selectedFilter;
      return true;
    }).toList();

    return Expanded(
      flex: 3,
      child: Column(
        children: [
          _buildIconFilterBar(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
              ),
              itemCount: displayed.length,
              itemBuilder: (context, i) {
                final h = displayed[i];
                bool isPicked = bluePicks.contains(h) || redPicks.contains(h);
                // Tim yang sama tidak bisa ban hero yang sama
                bool isBannedByCurrentSide = (banSide == "blue"
                    ? blueBans.contains(h.id)
                    : redBans.contains(h.id));
                // Hero yang sudah diban tim manapun tidak bisa di-PICK
                bool isBannedGlobal =
                    blueBans.contains(h.id) || redBans.contains(h.id);

                bool isDisabled =
                    isPicked ||
                    (isBanPhase ? isBannedByCurrentSide : isBannedGlobal);

                return GestureDetector(
                  onTap: isDisabled ? null : () => _handleSelection(h),
                  child: Opacity(
                    opacity: isDisabled ? 0.2 : 1.0,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: const Color(0xFF161B22),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              h.imageAsset,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              h.name,
                              style: const TextStyle(fontSize: 8),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Filter Bar dengan Ikon
  Widget _buildIconFilterBar() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          // Tombol Switch
          IconButton(
            icon: Icon(Icons.swap_vert, color: Color(0xFFC9A227)),
            onPressed: () => setState(() {
              categoryMode = categoryMode == "Class" ? "Lane" : "Class";
              selectedFilter = "All";
            }),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _filterIconButton("All", null),
                if (categoryMode == "Class")
                  ...HeroClass.values.map(
                    (e) => _filterIconButton(
                      e,
                      "assets/icon/class/${e.name.toLowerCase()}.png",
                    ),
                  ),
                if (categoryMode == "Lane")
                  ...RecommendedLane.values.map(
                    (e) => _filterIconButton(
                      e,
                      "assets/icon/lane/${e.name.toLowerCase()}.png",
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterIconButton(dynamic val, String? path) {
    bool isSel = selectedFilter == val;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = val),
      child: Container(
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSel ? Colors.amber : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: path == null
            ? const Center(
                child: Text(
                  "ALL",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )
            : Opacity(
                opacity: isSel ? 1.0 : 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(path),
                ),
              ),
      ),
    );
  }

  // Info Banning & Tombol Skip
  Widget _buildBanControlInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.red.withValues(alpha: 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${banSide.toUpperCase()} SIDE IS BANNING...",
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white10),
            onPressed: () => _handleSelection(null), // SKIP BAN
            child: const Text("SKIP / NONE", style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  // AI Helper Panel (Fuzzy Logic)
  Widget _buildAIHelper(List<RecommendationResult> recs) {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        border: Border(top: BorderSide(color: Color(0xFFC9A227))),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amber, size: 14),
              const SizedBox(width: 4),
              Text(
                "FUZZY AI: ${isBlueTurn ? 'BLUE' : 'RED'} SUGGESTION",
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: recs.isEmpty
                ? const Center(
                    child: Text(
                      "Tidak ada rekomendasi tersedia.",
                      style: TextStyle(color: Colors.white24, fontSize: 10),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recs.length,
                    itemBuilder: (c, i) {
                      final rec = recs[i];
                      return GestureDetector(
                        onTap: () => _handleSelection(rec.hero),
                        child: Container(
                          width: 130,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.amber.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      rec.hero.imageAsset,
                                      width: 28,
                                      height: 28,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.person, size: 28, color: Colors.white24),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          rec.hero.name,
                                          style: const TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Score: ${rec.totalFuzzyScore.toStringAsFixed(1)}",
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: rec.reasons.isEmpty
                                    ? const Text(
                                        "Pilihan Fleksibel",
                                        style: TextStyle(
                                          fontSize: 7,
                                          color: Colors.white54,
                                        ),
                                      )
                                    : ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white,
                                              Colors.white,
                                              Colors.white,
                                              Colors.transparent,
                                            ],
                                            stops: const [0.0, 0.7, 0.85, 1.0],
                                          ).createShader(bounds);
                                        },
                                        blendMode: BlendMode.dstIn,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: rec.reasons.length,
                                          itemBuilder: (context, r) {
                                            return Padding(
                                              padding: EdgeInsets.only(bottom: 2),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${r + 1}. ",
                                                    style: const TextStyle(
                                                      fontSize: 7,
                                                      color: Colors.amber,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      rec.reasons[r],
                                                      style: const TextStyle(
                                                        fontSize: 7,
                                                        color: Colors.white54,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishedBar() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    color: Colors.green[900],
    child: const Text(
      "DRAFT COMPLETED",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  // --- CORE LOGIC ---

  void _handleSelection(Hero? h) {
    setState(() {
      if (isBanPhase) {
        // Simpan Ban
        if (banSide == "blue") {
          blueBans[banStep] = h?.id;
        } else {
          redBans[banStep] = h?.id;
        }

        // Sequence Ban: Blue 3x, then Red 3x
        banStep++;
        if (banSide == "blue" && banStep > 2) {
          banSide = "red";
          banStep = 0;
        } else if (banSide == "red" && banStep > 2) {
          isBanPhase = false; // Ban selesai
        }
      } else {
        // Pick Phase
        if (totalPicked < 10 && h != null) {
          if (isBlueTurn) {
            bluePicks.add(h);
          } else {
            redPicks.add(h);
          }
          
          if (totalPicked == 10) {
            selectedHeroForRec = bluePicks.isNotEmpty ? bluePicks.first : null;
          }
        }
      }
    });
  }

  Widget _buildAnalysisPanel() {
    if (selectedHeroForRec == null) {
      return const Expanded(
        flex: 3,
        child: Center(
          child: Text(
            "PILIH HERO UNTUK REKOMENDASI",
            style: TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ),
      );
    }

    final hero = selectedHeroForRec!;
    bool isBlueHero = bluePicks.contains(hero);
    List<Hero> enemies = isBlueHero ? redPicks : bluePicks;
    List<Hero> allies = isBlueHero ? bluePicks : redPicks;

    final recResult = ItemRecommendationService.instance.recommendItems(
      hero: hero,
      enemyPicks: enemies,
      allyPicks: allies,
    );

    return Expanded(
      flex: 3,
      child: Container(
        color: const Color(0xFF0F141C),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Hero Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              color: Colors.black45,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(hero.imageAsset),
                    backgroundColor: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hero.name,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${hero.heroClassString} • ${hero.recommendedLane.name.toUpperCase()}",
                          style: const TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  // Mini tag for Side
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isBlueHero ? Colors.blue.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isBlueHero ? Colors.blue : Colors.red,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      isBlueHero ? "BLUE SIDE" : "RED SIDE",
                      style: TextStyle(
                        color: isBlueHero ? Colors.blueAccent : Colors.redAccent,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Recommended Build Section
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 12, bottom: 4),
              child: Text(
                "REKOMENDASI BUILD ITEM (SCROLL)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Vertical scrollable list of items
            Expanded(
              flex: 4,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: recResult.items.length,
                itemBuilder: (context, idx) {
                  final item = recResult.items[idx];
                  return GestureDetector(
                    onTap: () {
                      _showItemDetails(context, item);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Number Badge (Slot index)
                          Container(
                            width: 18,
                            height: 18,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.amber, width: 0.5),
                            ),
                            child: Text(
                              "${idx + 1}",
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item.imageUrl,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[900],
                                width: 32,
                                height: 32,
                                child: const Icon(Icons.inventory, size: 14, color: Colors.white30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.category,
                                  style: const TextStyle(fontSize: 8, color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white30),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Fired Rules / Analysis
            const Padding(
              padding: EdgeInsets.only(top: 6, left: 12, bottom: 4),
              child: Text(
                "ANALISIS & STRATEGI",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white10),
                ),
                child: recResult.firedRules.isEmpty
                    ? const Center(
                        child: Text(
                          "Menggunakan build standar hero.",
                          style: TextStyle(color: Colors.white38, fontSize: 10),
                        ),
                      )
                    : ListView.builder(
                        itemCount: recResult.firedRules.length,
                        itemBuilder: (c, i) {
                          final rule = recResult.firedRules[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.arrow_right, size: 14, color: Colors.amber),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    rule,
                                    style: const TextStyle(color: Colors.white70, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context, HokItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF161B22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFC9A227), width: 1),
          ),
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item.imageUrl,
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.inventory, size: 42),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.category,
                      style: const TextStyle(color: Colors.amber, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Stats:",
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                ...item.stats.entries.map((entry) {
                  String valStr = entry.value.toString();
                  if (entry.key.toLowerCase().contains("percent") || 
                      entry.key.toLowerCase().contains("reduction") || 
                      entry.key.toLowerCase().contains("rate") ||
                      entry.value < 1.0) {
                    valStr = "${(entry.value * 100).toStringAsFixed(1)}%";
                  } else {
                    valStr = "+${entry.value.toStringAsFixed(0)}";
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      "• ${entry.key}: $valStr",
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  );
                }),
                const SizedBox(height: 12),
                const Text(
                  "Passive:",
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  item.passive,
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup", style: TextStyle(color: Colors.amber)),
            ),
          ],
        );
      },
    );
  }
}
