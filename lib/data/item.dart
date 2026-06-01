import '../models/item.dart';

final items = [
  Item(
    id: 'item_1',
    name: 'Blade of Despair',
    imageAsset: 'assets/items/blade_of_despair.png',
    bonusStats: {'physicalAttack': 160, 'criticalRate': 5},
    passive: ItemEffect(
      name: 'Despair',
      description: 'Deal extra 25% damage to enemies below 50% HP',
      cooldown: 0,
    ),
    active: null,
  ),
  Item(
    id: 'item_2',
    name: 'Dominance Ice',
    imageAsset: 'assets/items/dominance_ice.png',
    bonusStats: {'physicalDefense': 110, 'cooldownReduction': 10},
    passive: ItemEffect(
      name: 'Arctic Cold',
      description: 'Reduces attack speed of nearby enemies by 30%',
      cooldown: 0,
    ),
    active: null,
  ),
  Item(
    id: 'item_3',
    name: 'Sea Halberd',
    imageAsset: 'assets/items/sea_halberd.png',
    bonusStats: {'physicalAttack': 80, 'attackSpeed': 15},
    passive: ItemEffect(
      name: 'Life Drain',
      description: 'Reduces enemy healing and lifesteal by 50% for 3s',
      cooldown: 0,
    ),
    active: null,
  ),
];