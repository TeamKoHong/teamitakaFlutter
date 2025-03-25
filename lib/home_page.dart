// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';
import 'widgets/bottom_navigation.dart'; // BottomNavigation 위젯 임포트

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 체크박스 상태 관리
  bool isTask1Checked = false;
  bool isTask2Checked = false;

  // 네비게이션 바의 현재 인덱스 관리
  int _currentIndex = 0;

  // 탭 전환 시 호출되는 메서드
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // 각 탭에 해당하는 화면을 반환하는 메서드
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent(); // 메인 탭 (기존 콘텐츠)
      case 1:
        return const Center(child: Text('프로젝트 관리 화면')); // 플레이스홀더
      case 2:
        return const Center(child: Text('팀매칭 화면')); // 플레이스홀더
      case 3:
        return const Center(child: Text('프로필 화면')); // 플레이스홀더
      default:
        return _buildHomeContent();
    }
  }

  // 기존 홈 콘텐츠를 별도의 메서드로 분리
  Widget _buildHomeContent() {
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
                      Image.asset(
                        'assets/images/profile.png',
                        width: 80, // 고정 크기 설정
                        height: 80, // 고정 크기 설정
                        fit: BoxFit.contain, // 이미지 잘림 방지
                        filterQuality: FilterQuality.high, // 고품질 필터링
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 40,
                            ),
                          );
                        },
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
                                    'UXUI',
                                    style: GoogleFonts.notoSansKr(
                                      color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 텍스트
                      Expanded(
                        child: Text(
                          '지표 엑셀에 정리하기',
                          style: GoogleFonts.notoSansKr(fontSize: 16),
                        ),
                      ),
                      // 체크박스
                      Checkbox(
                        value: isTask1Checked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isTask1Checked = newValue ?? false;
                          });
                        },
                        shape: const CircleBorder(),
                        activeColor: const Color(0xFFFF5733), // 체크 시 색상
                        checkColor: Colors.white, // 체크 표시 색상
                        side: const BorderSide(
                          color: Colors.grey, // 체크박스 테두리 색상
                          width: 1.5,
                        ),
                        visualDensity: VisualDensity.compact, // 크기 조정
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 탭 영역 축소
                      ),
                    ],
                  ),
                ),
                // 점선
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 텍스트
                      Expanded(
                        child: Text(
                          '자료 조사 및 분석하기',
                          style: GoogleFonts.notoSansKr(fontSize: 16),
                        ),
                      ),
                      // 체크박스
                      Checkbox(
                        value: isTask2Checked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isTask2Checked = newValue ?? false;
                          });
                        },
                        shape: const CircleBorder(),
                        activeColor: const Color(0xFFFF5733), // 체크 시 색상
                        checkColor: Colors.white, // 체크 표시 색상
                        side: const BorderSide(
                          color: Colors.grey, // 체크박스 테두리 색상
                          width: 1.5,
                        ),
                        visualDensity: VisualDensity.compact, // 크기 조정
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 탭 영역 축소
                      ),
                    ],
                  ),
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
          const SizedBox(height: 8),
          // ListView를 Column으로 대체하여 중첩 스크롤 문제 해결
          Column(
            children: [
              _buildRecruitmentCard(
                imagePath: 'assets/images/sample01.png',
                title: '김혜현 교수님 ] 비주얼 마케터 디자인 팀 프로젝트 인원 구합니다!',
                tag: '얼리버드',
                views: 302,
                comments: 76,
                date: '25.03.24',
              ),
              const SizedBox(height: 12),
              _buildRecruitmentCard(
                imagePath: 'assets/images/sample02.png',
                title: '김건상 교수님 ] 기초 디자인 테크닉 (2) 함께 스케치 디벨로퍼 구합니다. 스터디...',
                tag: '시라소니',
                views: 214,
                comments: 93,
                date: '25.03.27',
              ),
              const SizedBox(height: 12),
              _buildRecruitmentCard(
                imagePath: 'assets/images/sample03.png',
                title: '하연슬 교수님 ] 지도하에 공모전 함께 할 팀들러 구합니다!!',
                tag: '뱁새',
                views: 182,
                comments: 19,
                date: '25.03.12',
              ),
              const SizedBox(height: 80), // 네비게이션 바와의 간격 확보
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 배경색 설정
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
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

  Widget _buildRecruitmentCard({
    required String imagePath,
    required String title,
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
                  // 이미지 + "BEST" 라벨
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ),
                      // "BEST" 라벨 (좌측 상단)
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

                  // 텍스트 + 태그/조회수/댓글/날짜
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 제목
                        Text(
                          title,
                          style: GoogleFonts.notoSansKr(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        // 태그 + 조회수 + 댓글 + 날짜
                        Row(
                          children: [
                            // 태그
                            Text(
                              tag,
                              style: GoogleFonts.notoSansKr(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // 조회수 (눈 이모지)
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
                            // 댓글
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
                            const Spacer(), // 날짜를 우측으로 밀어냄
                            // 날짜
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
