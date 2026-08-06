import 'package:flutter/material.dart';

class Location {
  final String id;
  final String name;
  final double x;
  final double y;
  final Color color;
  final IconData icon;

  Location({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
    required this.color,
    required this.icon,
  });
}

final List<Location> gameLocations = [
  Location(id: 'home_sharma', name: 'Sharma House (Home)', x: 500, y: 500, color: Colors.blue, icon: Icons.home),
  Location(id: 'home_mama', name: 'Mama House', x: 800, y: 400, color: Colors.orange, icon: Icons.home_work),
  Location(id: 'home_bhature', name: 'Bhature House', x: 200, y: 700, color: Colors.purple, icon: Icons.house),
  Location(id: 'school', name: 'School', x: 600, y: 200, color: Colors.yellow, icon: Icons.school),
  Location(id: 'grocery', name: 'Grocery Shop', x: 400, y: 300, color: Colors.green, icon: Icons.shopping_cart),
  Location(id: 'park', name: 'Park', x: 800, y: 800, color: Colors.lightGreen, icon: Icons.park),
  Location(id: 'hospital', name: 'Hospital', x: 300, y: 150, color: Colors.red, icon: Icons.local_hospital),
  Location(id: 'police', name: 'Police Station', x: 900, y: 200, color: Colors.blueAccent, icon: Icons.local_police),
  Location(id: 'mall', name: 'Shopping Mall', x: 500, y: 900, color: Colors.pink, icon: Icons.local_mall),
];
