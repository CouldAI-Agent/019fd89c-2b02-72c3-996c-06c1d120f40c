import 'package:flutter/material.dart';
import '../models.dart';
import '../game_data.dart';
import 'house_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('City Map - Playing as Nannu'),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background representing an open world map
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://images.unsplash.com/photo-1519074069444-1ba4fff66d16?q=80&w=2000&auto=format&fit=crop', // Dark abstract map-like texture
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: gameFamilies.length,
              itemBuilder: (context, index) {
                final family = gameFamilies[index];
                return _buildHouseCard(context, family);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHouseCard(BuildContext context, Family family) {
    final color = Color(int.parse(family.houseColor));

    return Card(
      margin: const EdgeInsets.only(bottom: 24.0),
      color: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: color.withOpacity(0.5), width: 2),
      ),
      elevation: 8,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HouseScreen(family: family),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.home_work, color: color, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      family.houseName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                family.name,
                style: TextStyle(
                  color: color.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                family.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Enter House',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, color: color, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
