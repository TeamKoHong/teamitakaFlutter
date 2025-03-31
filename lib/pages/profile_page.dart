// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamitaka_flutter/pages/profile_info_page.dart';
import 'package:teamitaka_flutter/widgets/header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(
        title: '사용자님의 정보',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              '이름',
              style: GoogleFonts.notoSansKr(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              '사용자 이름',
              style: GoogleFonts.notoSansKr(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileInfoPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              '닉네임',
              style: GoogleFonts.notoSansKr(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              '사용자 닉네임',
              style: GoogleFonts.notoSansKr(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileInfoPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              '대학교',
              style: GoogleFonts.notoSansKr(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              '@@ 대학교',
              style: GoogleFonts.notoSansKr(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileInfoPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              '휴대폰 번호',
              style: GoogleFonts.notoSansKr(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              '010-****-****',
              style: GoogleFonts.notoSansKr(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileInfoPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              '이메일 주소',
              style: GoogleFonts.notoSansKr(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              '****@gmail.com',
              style: GoogleFonts.notoSansKr(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileInfoPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
