// lib/pages/one_button_dmi_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamitaka_flutter/pages/home_page.dart';
import 'package:teamitaka_flutter/pages/match_page.dart';
import 'package:teamitaka_flutter/pages/profile_info_page.dart';
import 'package:teamitaka_flutter/pages/projects_page.dart';
import 'package:teamitaka_flutter/widgets/bottom_navigation.dart';
import 'package:teamitaka_flutter/widgets/header.dart';

class OneButtonDMIPage extends StatelessWidget {
  const OneButtonDMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const Header(
        title: '완벽티미',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '완벽티미 페이지',
              style: GoogleFonts.notoSansKr(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileInfoPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5733),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '프로필로 이동',
                style: GoogleFonts.notoSansKr(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 3, // 프로필 탭과 연관
        onTap: (index) {
          switch (index) {
            case 0: // 메인
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1: // 프로젝트 관리
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProjectsPage()),
              );
              break;
            case 2: // 팀매칭
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MatchPage()),
              );
              break;
            case 3: // 프로필
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileInfoPage()),
              );
              break;
          }
        },
      ),
    );
  }
}
