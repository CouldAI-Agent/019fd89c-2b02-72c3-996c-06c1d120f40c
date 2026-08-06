import 'package:flutter/material.dart';

class Mission {
  final String id;
  final String title;
  final String description;
  bool isCompleted;

  Mission({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class InventoryItem {
  final String id;
  final String name;
  final String icon;
  int quantity;

  InventoryItem({
    required this.id,
    required this.name,
    required this.icon,
    this.quantity = 1,
  });
}

class GameState extends ChangeNotifier {
  int money = 0;
  int xp = 0;
  int reputation = 0;
  
  List<Mission> missions = [
    Mission(id: 'm1', title: 'Wake up', description: 'Brush teeth, eat breakfast, go to school.'),
    Mission(id: 'm2', title: 'Help Mummy', description: 'Buy groceries for mummy from the shop.'),
    Mission(id: 'm3', title: 'Visit Mama', description: 'Visit Mama\\'s house across the colony.'),
    Mission(id: 'm4', title: 'Prank Defense', description: 'Defeat the Bhature family\\'s prank.'),
  ];
  
  List<InventoryItem> inventory = [
    InventoryItem(id: 'i1', name: 'Bicycle Key', icon: '🚲'),
    InventoryItem(id: 'i2', name: 'School Bag', icon: '🎒'),
  ];

  void addMoney(int amount) {
    money += amount;
    notifyListeners();
  }

  void addXp(int amount) {
    xp += amount;
    notifyListeners();
  }

  void completeMission(String id) {
    final mission = missions.firstWhere((m) => m.id == id);
    if (!mission.isCompleted) {
      mission.isCompleted = true;
      addXp(100);
      addMoney(50);
      notifyListeners();
    }
  }
}
