// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'package:teamitaka_flutter/widgets/header.dart';
import 'home_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false, // 헤더와 콘텐츠 겹침 방지
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const Header(),
      body: const SafeArea(
        child: HomePage(), // TabBarView 대신 HomePage 직접 설정
      ),
    );
  }
}
