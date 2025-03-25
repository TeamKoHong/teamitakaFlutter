// lib/widgets/header.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// lib/widgets/header.dart
class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Text(
        'Teamitaka',
        style: GoogleFonts.montserrat(
          color: const Color(0xFFFF5733),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 500),
                child: const Icon(Icons.notifications, color: Colors.black),
              ),
              onPressed: () {
                // TODO: 알림
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
