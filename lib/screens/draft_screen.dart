import 'package:flutter/material.dart' hide Hero;
import '../models/hero.dart';
import '../models/item.dart';
import '../services/draft_service.dart';
import '../data/hero.dart';
import '../data/item.dart';

class DraftScreen extends StatefulWidget {
  @override
  _DraftScreenState createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  final DraftService _service = DraftService(allHeroes: heroes, allItems: items);

  Set<String> bannedIds = {};
  List<Hero> allyPicks = [];
  List<Hero> enemyPicks = [];
  List<Hero> recommendedHeroes = [];
  List<Item> recommendedItems = [];
  Hero? selectedMyHero;

  @override
  void initState() {
    super.initState();
    _updateRecommendations();
  }

  void _updateRecommendations() {
    setState(() {
      var available = _service.getAvailableHeroes(bannedIds, {...allyPicks.map((e) => e.id), ...enemyPicks.map((e) => e.id)});
      recommendedHeroes = _service.recommendHeroes(
        enemyPicks: enemyPicks,
        allyPicks: allyPicks,
        availableHeroes: available,
        topN: 5,
      );
      if (selectedMyHero != null) {
        recommendedItems = _service.recommendItemsAgainstEnemies(
          myHero: selectedMyHero!,
          enemyHeroes: enemyPicks,
          topN: 3,
        );
      }
    });
  }

  void _banHero(Hero hero) {
    setState(() {
      bannedIds.add(hero.id);
      _updateRecommendations();
    });
  }

  void _pickAlly(Hero hero) {
    setState(() {
      allyPicks.add(hero);
      _updateRecommendations();
    });
  }

  void _pickEnemy(Hero hero) {
    setState(() {
      enemyPicks.add(hero);
      _updateRecommendations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Draft Simulator')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildBanSection(),
                  _buildPickSection('Ally Picks', allyPicks, Colors.green, (h) => _pickAlly(h)),
                  _buildPickSection('Enemy Picks', enemyPicks, Colors.red, (h) => _pickEnemy(h)),
                  _buildRecommendationSection(),
                  if (selectedMyHero != null) _buildItemRecommendationSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Banned Heroes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: heroes.where((h) => bannedIds.contains(h.id)).map((h) => Chip(label: Text(h.name))).toList(),
            ),
            SizedBox(height: 8),
            Text('Tap to ban:'),
            Wrap(
              spacing: 8,
              children: heroes.where((h) => !bannedIds.contains(h.id)).map((h) {
                return ActionChip(
                  label: Text(h.name),
                  onPressed: () => _banHero(h),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickSection(String title, List<Hero> picks, Color color, Function(Hero) onPick) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            Wrap(
              spacing: 8,
              children: picks.map((h) => Chip(label: Text(h.name))).toList(),
            ),
            SizedBox(height: 8),
            Text('Tap to pick:'),
            Wrap(
              spacing: 8,
              children: heroes.where((h) => !bannedIds.contains(h.id) && !picks.contains(h) && !allyPicks.contains(h) && !enemyPicks.contains(h)).map((h) {
                return ActionChip(
                  label: Text(h.name),
                  onPressed: () => onPick(h),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recommended Heroes to Pick', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recommendedHeroes.map((h) => ListTile(
              title: Text(h.name),
              subtitle: Text('Class: ${h.heroClass}, Lane: ${h.recommendedLane}'),
              trailing: ElevatedButton(
                child: Text('Pick for Me'),
                onPressed: () {
                  setState(() {
                    selectedMyHero = h;
                    allyPicks.add(h);
                    _updateRecommendations();
                  });
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRecommendationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recommended Items for ${selectedMyHero!.name} against enemies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recommendedItems.map((item) => ListTile(
              title: Text(item.name),
              subtitle: Text('Passive: ${item.passive?.name ?? 'None'} - ${item.passive?.description ?? ''}'),
            )),
          ],
        ),
      ),
    );
  }
}