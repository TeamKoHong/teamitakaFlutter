// lib/pages/home_page.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:teamitaka_flutter/pages/match_page.dart';
import 'package:teamitaka_flutter/pages/profile_info_page.dart';
import 'package:teamitaka_flutter/pages/projects_page.dart';
import 'package:teamitaka_flutter/widgets/bottom_navigation.dart';
import 'package:teamitaka_flutter/widgets/header.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTask1Checked = false;
  bool isTask2Checked = false;
  bool isSaving = false;

  Future<bool> _requestPermission() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        final sdkVersion = androidInfo.version.sdkInt;

        if (sdkVersion >= 33) {
          final status = await Permission.photos.request();
          if (status.isGranted) {
            print("Android 13+: Photos permission granted");
            return true;
          }
          if (status.isPermanentlyDenied) {
            print("Android 13+: Photos permission permanently denied");
            await openAppSettings();
            return false;
          }
          print("Android 13+: Photos permission denied");
          return false;
        } else {
          final storageStatus = await Permission.storage.request();
          if (storageStatus.isGranted) {
            print("Android 12-: Storage permission granted");
            return true;
          }
          if (storageStatus.isPermanentlyDenied) {
            print("Android 12-: Storage permission permanently denied");
            await openAppSettings();
            return false;
          }
          print("Android 12-: Storage permission denied");
          return false;
        }
      } else if (Platform.isIOS) {
        final permissionStatus = await PhotoManager.requestPermissionExtend();
        print("iOS: PhotoManager permission status: $permissionStatus");
        if (permissionStatus == PermissionState.authorized) {
          print("iOS: PhotoManager permission granted");
          return true;
        }
        if (permissionStatus == PermissionState.limited) {
          print("iOS: PhotoManager permission limited");
          return true;
        }
        if (permissionStatus == PermissionState.denied) {
          print("iOS: PhotoManager permission denied");
          await openAppSettings();
          return false;
        }
        print("iOS: PhotoManager permission status unknown");
        return false;
      }
      return false;
    } catch (e) {
      print("Permission request error: $e");
      return false;
    }
  }

  Future<void> _saveNetworkImage() async {
    setState(() => isSaving = true);

    try {
      final hasPermission = await _requestPermission();
      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장 권한이 필요합니다. 설정에서 권한을 허용해주세요.')),
        );
        setState(() => isSaving = false);
        return;
      }

      const imageUrl = 'https://picsum.photos/200/300';
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception("Failed to download image: ${response.statusCode}");
      }

      final imageBytes = response.bodyBytes;
      final filename =
          'network_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final result = await PhotoManager.editor.saveImage(
        imageBytes,
        filename: filename,
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미지가 갤러리에 저장되었습니다!')),
        );
      } else {
        throw Exception("PhotoManager failed to save image");
      }
    } catch (e) {
      print("Save network image error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지 저장 실패: $e')),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      Image.asset(
                        'assets/images/profile.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '김조형',
                              style: GoogleFonts.notoSansKr(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '홍익대학교 디자인과 재학 중',
                              style: GoogleFonts.notoSansKr(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '지표 엑셀에 정리하기',
                          style: GoogleFonts.notoSansKr(fontSize: 16),
                        ),
                      ),
                      Checkbox(
                        value: isTask1Checked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isTask1Checked = newValue ?? false;
                          });
                        },
                        shape: const CircleBorder(),
                        activeColor: const Color(0xFFFF5733),
                        checkColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '자료 조사 및 분석하기',
                          style: GoogleFonts.notoSansKr(fontSize: 16),
                        ),
                      ),
                      Checkbox(
                        value: isTask2Checked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isTask2Checked = newValue ?? false;
                          });
                        },
                        shape: const CircleBorder(),
                        activeColor: const Color(0xFFFF5733),
                        checkColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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
              TextButton(
                onPressed: _saveNetworkImage,
                child: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFFF5733),
                        ),
                      )
                    : Text(
                        '이미지 저장',
                        style: GoogleFonts.notoSansKr(
                          fontSize: 14,
                          color: const Color(0xFFFF5733),
                        ),
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
          Text(
            '모집 마감 임박 프로젝트 🔥',
            style: GoogleFonts.notoSansKr(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
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
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const Header(), // title 파라미터 제거
      body: _buildHomeContent(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return; // 현재 페이지 (홈)일 경우 이동하지 않음
          switch (index) {
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
