// lib/pages/projects_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamitaka_flutter/pages/home_page.dart';
import 'package:teamitaka_flutter/pages/match_page.dart';
import 'package:teamitaka_flutter/pages/profile_info_page.dart';
import 'package:teamitaka_flutter/widgets/bottom_navigation.dart';
import 'package:teamitaka_flutter/widgets/header.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const Header(
        title: '프로젝트 관리',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '진행 중인 프로젝트',
              style: GoogleFonts.notoSansKr(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // 더미 프로젝트 리스트
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  '프로젝트명',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '고정 회의 시간',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                trailing: Text(
                  'D-07',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF5733),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) return; // 현재 페이지 (프로젝트 관리)일 경우 이동하지 않음
          switch (index) {
            case 0: // 메인
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
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
