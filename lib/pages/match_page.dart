// lib/pages/match_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamitaka_flutter/pages/home_page.dart';
import 'package:teamitaka_flutter/pages/profile_info_page.dart';
import 'package:teamitaka_flutter/pages/projects_page.dart';
import 'package:teamitaka_flutter/widgets/bottom_navigation.dart';
import 'package:teamitaka_flutter/widgets/header.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const Header(
        title: '팀매칭',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '모집 중인 팀 🔥',
              style: GoogleFonts.notoSansKr(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // 팀매칭 리스트
            _buildTeamCard(
              title: '비주얼 마케터 디자인 팀',
              professor: '김혜현 교수님',
              tag: '얼리버드',
              views: 302,
              comments: 76,
              date: '25.03.24',
            ),
            const SizedBox(height: 12),
            _buildTeamCard(
              title: '기초 디자인 테크닉 (2) 스케치 디벨로퍼',
              professor: '김건상 교수님',
              tag: '시라소니',
              views: 214,
              comments: 93,
              date: '25.03.27',
            ),
            const SizedBox(height: 12),
            _buildTeamCard(
              title: '공모전 팀 모집',
              professor: '하연슬 교수님',
              tag: '뱁새',
              views: 182,
              comments: 19,
              date: '25.03.12',
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 2,
        onTap: (index) {
          if (index == 2) return; // 현재 페이지 (팀매칭)일 경우 이동하지 않음
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

  Widget _buildTeamCard({
    required String title,
    required String professor,
    required String tag,
    required int views,
    required int comments,
    required String date,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.black.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.group,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            'BEST',
                            style: GoogleFonts.notoSansKr(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$professor ] $title',
                          style: GoogleFonts.notoSansKr(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              tag,
                              style: GoogleFonts.notoSansKr(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '$views',
                                  style: GoogleFonts.notoSansKr(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.message_outlined,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '$comments',
                                  style: GoogleFonts.notoSansKr(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              date,
                              style: GoogleFonts.notoSansKr(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
