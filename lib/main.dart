// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

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
