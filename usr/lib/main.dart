import 'package:flutter/material.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const FamilyGameApp());
}

class FamilyGameApp extends StatelessWidget {
  const FamilyGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Open World',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MapScreen(),
      },
    );
  }
}
