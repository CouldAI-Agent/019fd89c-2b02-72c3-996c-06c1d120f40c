import 'package:flutter/material.dart';
import '../models.dart';

class HouseScreen extends StatelessWidget {
  final Family family;

  const HouseScreen({super.key, required this.family});

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(family.houseColor));

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(family.houseName),
        backgroundColor: color.withOpacity(0.3),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.3), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Icon(Icons.apartment, size: 64, color: color),
                const SizedBox(height: 16),
                Text(
                  family.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${family.members.length} Characters present',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: family.members.length,
              itemBuilder: (context, index) {
                final member = family.members[index];
                return _buildCharacterCard(member, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterCard(Character character, Color color) {
    return Card(
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: character.isMainCharacter ? Colors.amber : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: character.isMainCharacter ? Colors.amber.withOpacity(0.2) : color.withOpacity(0.2),
            child: Icon(
              character.isMainCharacter ? Icons.star : Icons.person,
              size: 40,
              color: character.isMainCharacter ? Colors.amber : color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            character.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            character.role,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
