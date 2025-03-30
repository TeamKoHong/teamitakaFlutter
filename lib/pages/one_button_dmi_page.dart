import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class OneButtonDMIPage extends StatefulWidget {
  const OneButtonDMIPage({super.key});

  @override
  State<OneButtonDMIPage> createState() => _OneButtonDMIPageState();
}

class _OneButtonDMIPageState extends State<OneButtonDMIPage> {
  final GlobalKey _repaintBoundaryKey = GlobalKey();
  bool isSaving = false;

  Future<bool> _requestPermission() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        final sdkVersion = androidInfo.version.sdkInt;

        if (sdkVersion >= 33) {
          final status = await Permission.photos.request();
          return status.isGranted;
        } else {
          final storageStatus = await Permission.storage.request();
          return storageStatus.isGranted;
        }
      } else if (Platform.isIOS) {
        final permissionStatus = await PhotoManager.requestPermissionExtend();
        return permissionStatus == PermissionState.authorized ||
            permissionStatus == PermissionState.limited;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _captureAndSave() async {
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

      final boundary = _repaintBoundaryKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception("Image conversion failed");
      final imageBytes = byteData.buffer.asUint8List();

      final filename =
          'one_button_dmi_${DateTime.now().millisecondsSinceEpoch}.png';
      final result = await PhotoManager.editor.saveImage(
        imageBytes,
        filename: filename,
        title: filename,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(result != null ? '이미지가 갤러리에 저장되었습니다!' : '이미지 저장 실패')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지 저장 실패: $e')),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF76241), // 정확한 디자인 색상
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              '티미가 된 것을 축하해!',
              style: GoogleFonts.notoSansKr(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: _repaintBoundaryKey,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '완벽티미',
                          style: GoogleFonts.notoSansKr(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF76241)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '빠트린거 없이 완벽해! 준비 되어 있어!',
                          style: GoogleFonts.notoSansKr(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Image.asset(
                          'assets/images/perfect.png',
                          width: 150,
                          height: 150,
                        ),
                        const Divider(height: 32),
                        Row(children: [
                          Text('💡', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text('더 나은 방법이 있을거야!',
                              style: GoogleFonts.notoSansKr(fontSize: 16)),
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          Text('🔍', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text('이유를 분석해보자',
                              style: GoogleFonts.notoSansKr(fontSize: 16)),
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          Text('📣', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text('이걸 어떻게 팀원들에게 설명해줄까?',
                                style: GoogleFonts.notoSansKr(fontSize: 16)),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton.icon(
                onPressed: isSaving ? null : _captureAndSave,
                icon: Icon(Icons.download, color: Colors.black, size: 26),
                label: Text('이미지 저장',
                    style: GoogleFonts.notoSansKr(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
