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
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: const Color(0xFFFF5733),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.notoSansKr(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.notoSansKr(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: '메인',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description, size: 24),
            label: '프로젝트 관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share, size: 24),
            label: '팀매칭',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
