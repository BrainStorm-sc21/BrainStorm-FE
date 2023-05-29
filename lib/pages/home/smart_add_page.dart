import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/pages/home/submit_image_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SmartAddPage extends StatefulWidget {
  final int userId;
  const SmartAddPage({
    super.key,
    required this.userId,
  });

  @override
  State<SmartAddPage> createState() => _SmartAddPageState();
}

class _SmartAddPageState extends State<SmartAddPage> {
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    cameras = await availableCameras();
    camera = cameras.first;
    setState(() => isCameraInitialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (isCameraInitialized) {
      return SubmitImagePage(camera: camera);
    } else {
      return Container(
        color: ColorStyles.mainColor,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }
}
