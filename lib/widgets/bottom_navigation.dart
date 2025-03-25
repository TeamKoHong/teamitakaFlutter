// lib/widgets/bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: TabBar(
        onTap: onTap,
        labelColor: const Color(0xFFFF5733),
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.notoSansKr(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.notoSansKr(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          insets: EdgeInsets.symmetric(horizontal: 16),
        ),
        tabs: const [
          Tab(
            icon: Icon(Icons.home, size: 24),
            text: '메인',
          ),
          Tab(
            icon: Icon(Icons.description, size: 24),
            text: '프로젝트 관리',
          ),
          Tab(
            icon: Icon(Icons.share, size: 24),
            text: '팀매칭',
          ),
          Tab(
            icon: Icon(Icons.person, size: 24),
            text: '프로필',
          ),
        ],
      ),
    );
  }
}
