class Item {
  final String id;
  final String name;
  final String imageAsset; // path ke asset gambar
  final Map<String, int> bonusStats; // misal {"physicalAttack": 80, "maxHealth": 500}
  final ItemEffect? passive;
  final ItemEffect? active;

  Item({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.bonusStats,
    this.passive,
    this.active,
  });
}

class ItemEffect {
  final String name;
  final String description;
  final double cooldown; // dalam detik

  ItemEffect({
    required this.name,
    required this.description,
    required this.cooldown,
  });
}