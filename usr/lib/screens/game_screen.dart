import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../engine/game_state.dart';
import '../models/location.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Player position in the world
  double playerX = 500;
  double playerY = 520;
  
  // Joystick state
  Offset joystickDelta = Offset.zero;
  bool isMoving = false;
  
  final double playerSpeed = 5.0;

  @override
  void initState() {
    super.initState();
    _gameLoop();
  }

  void _gameLoop() async {
    while (mounted) {
      if (isMoving && joystickDelta != Offset.zero) {
        setState(() {
          playerX += joystickDelta.dx * playerSpeed;
          playerY += joystickDelta.dy * playerSpeed;
          
          // Basic bounds
          playerX = playerX.clamp(0.0, 1000.0);
          playerY = playerY.clamp(0.0, 1000.0);
        });
      }
      await Future.delayed(const Duration(milliseconds: 16)); // ~60fps
    }
  }

  void _openPhone() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const InGamePhoneScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate camera offset to keep player centered
    final screenSize = MediaQuery.of(context).size;
    final cameraX = (screenSize.width / 2) - playerX;
    final cameraY = (screenSize.height / 2) - playerY;

    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      body: Stack(
        children: [
          // The World Map
          Positioned(
            left: cameraX,
            top: cameraY,
            child: Container(
              width: 1000,
              height: 1000,
              decoration: BoxDecoration(
                color: const Color(0xFF34495E),
                border: Border.all(color: Colors.white24, width: 2),
              ),
              child: Stack(
                children: [
                  // Draw Locations
                  ...gameLocations.map((loc) => Positioned(
                    left: loc.x - 30,
                    top: loc.y - 30,
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: loc.color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(loc.icon, color: Colors.white, size: 30),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          loc.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                          ),
                        ),
                      ],
                    ),
                  )),
                  // Draw Player (Nannu)
                  Positioned(
                    left: playerX - 20,
                    top: playerY - 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 2))
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '🧑', // Nannu avatar placeholder
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // UI Overlay
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: _openPhone,
                  backgroundColor: Colors.black87,
                  child: const Icon(Icons.smartphone, color: Colors.white),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<GameState>(
                  builder: (context, state, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${state.money}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Virtual Joystick
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    isMoving = true;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    // Normalize the delta
                    final offset = details.localPosition - const Offset(60, 60);
                    if (offset.distance > 10) {
                      joystickDelta = Offset(offset.dx / offset.distance, offset.dy / offset.distance);
                    }
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    isMoving = false;
                    joystickDelta = Offset.zero;
                  });
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InGamePhoneScreen extends StatelessWidget {
  const InGamePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameState>(context);
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade800, width: 4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Scaffold(
          backgroundColor: Colors.blueGrey.shade900,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Nannu\\'s Phone'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard('Money', '₹${state.money}', Icons.account_balance_wallet, Colors.green),
                    _buildStatCard('XP', '${state.xp}', Icons.star, Colors.amber),
                    _buildStatCard('Rep', '${state.reputation}', Icons.favorite, Colors.pink),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Missions', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.missions.length,
                    itemBuilder: (context, index) {
                      final mission = state.missions[index];
                      return Card(
                        color: Colors.black45,
                        child: ListTile(
                          leading: Icon(
                            mission.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: mission.isCompleted ? Colors.green : Colors.grey,
                          ),
                          title: Text(mission.title, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(mission.description, style: const TextStyle(color: Colors.white70)),
                          trailing: !mission.isCompleted ? IconButton(
                            icon: const Icon(Icons.play_arrow, color: Colors.blue),
                            onPressed: () {
                              state.completeMission(mission.id);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Completed: ${mission.title}! +100 XP')));
                            },
                          ) : null,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Inventory', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.inventory.length,
                    itemBuilder: (context, index) {
                      final item = state.inventory[index];
                      return Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.icon, style: const TextStyle(fontSize: 24)),
                            const SizedBox(height: 4),
                            Text(item.name, style: const TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
