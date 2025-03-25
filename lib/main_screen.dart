// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'projects_page.dart';
import 'match_page.dart';
import 'profile_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // 바탕색
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Teamitaka',
            style: GoogleFonts.montserrat(
              color: const Color(0xFFFF5733),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            // 알림 아이콘만 남김 (QR은 프로필 카드로 이동)
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                // TODO: 알림
              },
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            ProjectsPage(),
            MatchPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: TabBar(
            labelColor: const Color(0xFFFF5733),
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(icon: Icon(Icons.home), text: '메인'),
              Tab(icon: Icon(Icons.description), text: '프로젝트'),
              Tab(icon: Icon(Icons.share), text: '팀매칭'),
              Tab(icon: Icon(Icons.person), text: '프로필'),
            ],
          ),
        ),
      ),
    );
  }
}
