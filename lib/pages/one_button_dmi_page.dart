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
          // Android 13 이상
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
          // Android 12 이하
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
          return true; // 제한된 접근도 허용
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

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미지가 갤러리에 저장되었습니다!')),
        );
      } else {
        throw Exception("PhotoManager failed to save image");
      }
    } catch (e) {
      print("Capture and save error: $e");
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
      backgroundColor: const Color(0xFFFF5733),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              '티미가 단것을 축하해!!',
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
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '원버튼DMI',
                          style: GoogleFonts.notoSansKr(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '빠른건 강한 얍배를 준비 되어 있어',
                          style: GoogleFonts.notoSansKr(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFFF5733),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 20,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 20,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.lightbulb_outline,
                                size: 24, color: Colors.black),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '디 나온 발병이 있울거야!\n이유를 분석하겠자',
                                style: GoogleFonts.notoSansKr(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.search,
                                size: 24, color: Colors.black),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '이걸 어떻게 팀원들에게 설멍해줄까?',
                                style: GoogleFonts.notoSansKr(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: isSaving ? null : _captureAndSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFFF5733),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Color(0xFFFF5733),
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  '시작하기',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF5733),
                  ),
                ),
        ),
      ),
    );
  }
}
