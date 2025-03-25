// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------
          // (1) 프로필 섹션
          // -----------------------------
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      // (A) 요가 캐릭터
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFF5733).withOpacity(0.2),
                            ),
                          ),
                          Image.asset(
                            'assets/images/profile.png',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),

                      // (B) 텍스트 영역
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 이름
                            Text(
                              '김조형',
                              style: GoogleFonts.notoSansKr(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // (1) 학교
                            Text(
                              '홍익대학교 디자인과 재학 중',
                              style: GoogleFonts.notoSansKr(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // (2) 브랜딩/UXUI 버튼 (더 아래쪽)
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF5733),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                  ),
                                  child: Text(
                                    '브랜딩',
                                    style: GoogleFonts.notoSansKr(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.grey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                  ),
                                  child: Text(
                                    'UXUI',
                                    style: GoogleFonts.notoSansKr(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // (3) 팀플 경험 5회...
                            Text(
                              '팀플 경험 5회 • 진행 중 프로젝트 3개',
                              style: GoogleFonts.notoSansKr(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // (C) QR코드 (우측 상단)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF5733),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.qr_code,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // -----------------------------
          // (2) 오늘의 할 일
          // -----------------------------
          Text(
            '오늘의 할 일',
            style: GoogleFonts.notoSansKr(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Column(
              children: [
                // 체크박스 1
                CheckboxListTile(
                  // (A) 원형
                  shape: const CircleBorder(),
                  // (B) 오른쪽 정렬
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    '지표 엑셀에 정리하기',
                    style: GoogleFonts.notoSansKr(fontSize: 16),
                  ),
                  value: false,
                  onChanged: (bool? newValue) {
                    // TODO
                  },
                ),
                // dotted line
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: Colors.grey,
                    dashGapLength: 4.0,
                  ),
                ),
                // 체크박스 2
                CheckboxListTile(
                  shape: const CircleBorder(),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    '자료 조사 및 분석하기',
                    style: GoogleFonts.notoSansKr(fontSize: 16),
                  ),
                  value: false,
                  onChanged: (bool? newValue) {
                    // TODO
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // -----------------------------
          // (3) 진행중인 프로젝트
          // -----------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '진행중인 프로젝트',
                style: GoogleFonts.notoSansKr(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '2차례 진행',
                style: GoogleFonts.notoSansKr(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildProjectCard('프로젝트명', '고정 회의 시간', 'D-07'),
                const SizedBox(width: 12),
                _buildProjectCard('프로젝트명2', '고정 회의 시간', 'D-10'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // -----------------------------
          // (4) 모집 마감 임박 프로젝트
          // -----------------------------
          Text(
            '모집 마감 임박 프로젝트 🔥',
            style: GoogleFonts.notoSansKr(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // TODO: 추가 컨텐츠
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String subTitle, String dDay) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // 왼쪽 아이콘
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.group, color: Colors.white),
            ),
            const SizedBox(width: 12),
            // 중앙 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.notoSansKr(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: GoogleFonts.notoSansKr(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 팀원 아이콘들
                  Row(
                    children: [
                      _buildMemberIcon(),
                      const SizedBox(width: 4),
                      _buildMemberIcon(),
                      const SizedBox(width: 4),
                      _buildMemberIcon(),
                    ],
                  ),
                ],
              ),
            ),
            // 오른쪽 D-07
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFF5733),
                  width: 4,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                dDay,
                style: GoogleFonts.notoSansKr(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberIcon() {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Colors.grey[200],
      child: const Icon(Icons.person, size: 14, color: Colors.grey),
    );
  }
}
