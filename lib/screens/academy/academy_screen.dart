import 'package:flutter/material.dart' hide Hero;
import '../../models/hero_model.dart';
import '../../services/database_service.dart';
import '../../services/draft_service.dart';

class AcademyPage extends StatefulWidget {
  const AcademyPage({super.key});

  @override
  State<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
  late Future<List<Hero>> _heroesFuture;
  List<Hero> _allHeroes = [];
  Set<String> bannedIds = {};
  List<Hero> bluePicks = [];
  List<Hero> redPicks = [];
  
  bool isBanPhase = true;
  String categoryMode = "Class"; // "Class" or "Lane"
  dynamic selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    _heroesFuture = _loadData();
  }

  Future<List<Hero>> _loadData() async {
    final heroes = await DatabaseService.instance.getAllHeroesWithRelations();
    setState(() => _allHeroes = heroes);
    return heroes;
  }

  // Fungsi Reset Draft
  void _resetDraft() {
    setState(() {
      bannedIds.clear();
      bluePicks.clear();
      redPicks.clear();
      isBanPhase = true;
      selectedFilter = "All";
    });
  }

  // Logika Urutan Pick
  int get totalPicked => bluePicks.length + redPicks.length;
  bool get isBlueTurn {
    // Urutan: B1, R1, R2, B2, B3, R3, R4, B4, B5, R5
    List<int> blueTurns = [0, 3, 4, 7, 8];
    return blueTurns.contains(totalPicked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HOKU DRAFT SIMULATOR", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC9A227))),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.redAccent),
            onPressed: _resetDraft, // Tombol Reset
            tooltip: "Reset Draft",
          ),
          if (isBanPhase)
            TextButton(
              onPressed: () => setState(() => isBanPhase = false),
              child: const Text("START PICK", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
            )
        ],
      ),
      body: FutureBuilder<List<Hero>>(
        future: _heroesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          
          var recs = isBanPhase || totalPicked >= 10 ? <Map<String, dynamic>>[] : DraftEngine.recommend(
            allHeroes: _allHeroes,
            bannedIds: bannedIds,
            allyPicks: isBlueTurn ? bluePicks : redPicks,
            enemyPicks: isBlueTurn ? redPicks : bluePicks,
          );

          return Column(
            children: [
              _buildBanHeader(),
              Expanded(
                child: Row(
                  children: [
                    _buildPickColumn(bluePicks, "BLUE TEAM", Colors.blue, true),
                    _buildHeroPool(),
                    _buildPickColumn(redPicks, "RED TEAM", Colors.red, false),
                  ],
                ),
              ),
              if (!isBanPhase && totalPicked < 10) _buildAIHelper(recs),
              if (totalPicked >= 10) _buildFinalMessage(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBanHeader() {
    return Container(
      height: 70,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (i) {
          String? id = bannedIds.length > i ? bannedIds.elementAt(i) : null;
          Hero? bannedHero = id != null ? _allHeroes.firstWhere((h) => h.id == id) : null;
          return Container(
            width: 45, height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(4),
              image: bannedHero != null ? DecorationImage(
                image: NetworkImage(bannedHero.imageAsset),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken)
              ) : null,
            ),
            child: id == null ? const Icon(Icons.not_interested, size: 18, color: Colors.white10) : null,
          );
        }),
      ),
    );
  }

  Widget _buildHeroPool() {
    List<Hero> displayed = _allHeroes.where((h) {
      if (selectedFilter == "All") return true;
      if (categoryMode == "Class") return h.heroClass.contains(selectedFilter);
      if (categoryMode == "Lane") return h.recommendedLane == selectedFilter;
      return true;
    }).toList();

    return Expanded(
      flex: 3,
      child: Container(
        decoration: const BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: Colors.white10))),
        child: Column(
          children: [
            // Filter Bar dengan Tombol Switch
            Container(
              height: 45,
              color: Colors.white.withOpacity(0.02),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.swap_horiz, color: Color(0xFFC9A227)),
                    onPressed: () => setState(() {
                      categoryMode = categoryMode == "Class" ? "Lane" : "Class";
                      selectedFilter = "All";
                    }),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _filterBtn("All"),
                        if (categoryMode == "Class") ...HeroClass.values.map((e) => _filterBtn(e)),
                        if (categoryMode == "Lane") ...RecommendedLane.values.map((e) => _filterBtn(e)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.8),
                itemCount: displayed.length,
                itemBuilder: (context, i) {
                  final h = displayed[i];
                  bool isTaken = bannedIds.contains(h.id) || bluePicks.contains(h) || redPicks.contains(h);
                  return GestureDetector(
                    onTap: (isTaken || (totalPicked >= 10 && !isBanPhase)) ? null : () => _selectHero(h),
                    child: Opacity(
                      opacity: isTaken ? 0.2 : 1.0,
                      child: Card(
                        color: const Color(0xFF161B22),
                        child: Column(
                          children: [
                            Expanded(child: Image.network(h.imageAsset, fit: BoxFit.cover, width: double.infinity)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(h.name, style: const TextStyle(fontSize: 9), overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _selectHero(Hero h) {
    setState(() {
      if (isBanPhase) {
        if (bannedIds.length < 6) bannedIds.add(h.id);
      } else {
        if (totalPicked < 10) { // Cek agar tidak melebihi 5v5
          if (isBlueTurn) bluePicks.add(h);
          else redPicks.add(h);
        }
      }
    });
  }

  Widget _buildPickColumn(List<Hero> picks, String side, Color color, bool isLeft) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(side, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          ...List.generate(5, (i) {
            Hero? h = i < picks.length ? picks[i] : null;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.all(2),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.05),
                  border: Border(
                    left: isLeft ? BorderSide(color: color, width: 3) : BorderSide.none,
                    right: !isLeft ? BorderSide(color: color, width: 3) : BorderSide.none
                  ),
                  image: h != null ? DecorationImage(image: NetworkImage(h.imageAsset), fit: BoxFit.cover) : null,
                ),
                child: h == null ? const Center(child: Text("?", style: TextStyle(color: Colors.white10))) : null,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAIHelper(List<Map<String, dynamic>> recs) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        border: Border(top: BorderSide(color: Color(0xFFC9A227), width: 2))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AI RECOMMENDATION: ${isBlueTurn ? 'BLUE' : 'RED'} TURN", 
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFC9A227))),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recs.length,
              itemBuilder: (context, i) {
                final h = recs[i]['hero'] as Hero;
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      Text(h.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white)),
                      Text(recs[i]['reason'], style: const TextStyle(fontSize: 8, color: Colors.white54), textAlign: TextAlign.center, maxLines: 2),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      color: Colors.green.withOpacity(0.2),
      child: const Text("DRAFT COMPLETED! Good luck in the Rift.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
    );
  }

  Widget _filterBtn(dynamic val) {
    bool isSel = selectedFilter == val;
    String label = (val is String) ? val : val.toString().split('.').last;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = val),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: isSel ? Colors.white : Colors.white38, fontSize: 11, fontWeight: isSel ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }
}