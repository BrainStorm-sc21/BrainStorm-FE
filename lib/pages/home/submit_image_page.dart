import 'dart:io';

import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SubmitImagePage extends StatefulWidget {
  final CameraDescription camera;
  const SubmitImagePage({
    super.key,
    required this.camera,
  });

  @override
  State<SubmitImagePage> createState() => _SubmitImagePageState();
}

class _SubmitImagePageState extends State<SubmitImagePage> {
  late CameraController _controller;
  late Future<void> _initControllerFuture;
  final ImagePicker picker = ImagePicker();
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  void initState() {
    super.initState();
    initCamera();

    // show guide popup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Popups.showSmartAddGuide(context);
    });
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

  Future<void> captureImage() async {
    await _initControllerFuture;
    final XFile capturedImageFile = await _controller.takePicture();
    if (!mounted) return;
    setState(() {
      _pickedFile = capturedImageFile;
    });
    cropImage();
  }

  Future<void> getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        debugPrint('선택 이미지: ${_pickedFile.hashCode}');
      });
      cropImage();
    }
  }

  Future<void> cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile!.path,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 80,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '',
          toolbarColor: ColorStyles.black,
          toolbarWidgetColor: ColorStyles.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: '',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
        debugPrint('크롭 이미지: ${_croppedFile.hashCode}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double? mediaWidth = MediaQuery.of(context).size.width;
    double? mediaHeight = MediaQuery.of(context).size.height;

    // crop한 이미지가 있는 경우, crop한 이미지를 보여주고 이미지 type 선택
    if (_croppedFile != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
          actions: [
            IconButton(
              onPressed: () {
                Popups.selectImageType(context, _croppedFile);
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: Container(
          color: ColorStyles.black,
          child: Center(
            child: Image.file(
              File(_croppedFile!.path),
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }
    // crop한 이미지가 없는 경우(=이미지를 선택하지 않은 경우), 사진 촬영/선택
    else {
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
                  child: Stack(
                    children: [
                      // 갤러리 버튼
                      Align(
                        alignment: const Alignment(-0.7, 0),
                        child: IconButton(
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          icon: const Icon(Icons.photo),
                        ),
                      ),
                      // 사진 촬영 버튼
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            captureImage();
                          },
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
