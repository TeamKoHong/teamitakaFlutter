// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamitaka_flutter/pages/home_page.dart';
import 'package:teamitaka_flutter/splash_screen.dart'; // 추가

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
        scaffoldBackgroundColor: Colors.grey[100], // 기본 배경색 설정
        textTheme: GoogleFonts.notoSansKrTextTheme(), // 앱 전체 폰트 설정
      ),
      home: const SplashScreen(),
    );
  }
}
