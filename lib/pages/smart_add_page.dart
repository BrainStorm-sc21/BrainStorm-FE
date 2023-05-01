import 'package:brainstorm_meokjang/pages/take_picture_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SmartAddPage extends StatefulWidget {
  const SmartAddPage({super.key});

  @override
  State<SmartAddPage> createState() => _SmartAddPageState();
}

class _SmartAddPageState extends State<SmartAddPage> {
  late List<CameraDescription> cameras;
  late CameraDescription camera;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    cameras = await availableCameras();
    camera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return TakePicturePage(camera: camera);
  }
}
