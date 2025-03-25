// lib/main.dart
import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const TeamitakaFlutterApp());
}

class TeamitakaFlutterApp extends StatelessWidget {
  const TeamitakaFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeamitakaFlutter',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SplashScreen(),
    );
  }
}
