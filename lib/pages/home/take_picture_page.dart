import 'dart:io';

import 'package:brainstorm_meokjang/pages/home/ocr_result_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;
  const TakePicturePage({
    super.key,
    required this.camera,
  });

  @override
  State<TakePicturePage> createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  late CameraController _controller;
  late Future<void> _initControllerFuture;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _initControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? mediaWidth = MediaQuery.of(context).size.width;
    double? mediaHeight = MediaQuery.of(context).size.height;

    // 사진 촬영 시 실행될 함수
    /// 촬영한 사진을 backend로 보내기
    /// 응답 변수를 만들어서 nav) res ? {OCRResult} : {loading}
    Future<void> takePicture() async {
      try {
        await _initControllerFuture;
        final image = await _controller.takePicture();
        if (!mounted) return;
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OCRResultPage(
              image: Image.file(File(image.path)),
            ),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // 카메라 뷰 빌더
            FutureBuilder<void>(
              future: _initControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: mediaWidth,
                    height: mediaHeight,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller), // 실제 카메라 뷰
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            // 하단 바
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 120.0,
                color: const Color.fromRGBO(0, 0, 0, 0.8),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => takePicture(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.8),
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: Color.fromRGBO(35, 204, 135, 1.0),
                          width: 5.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: const BoxDecoration(
                          color: ColorStyles.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
