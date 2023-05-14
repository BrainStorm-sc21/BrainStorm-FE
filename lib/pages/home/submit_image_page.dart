import 'dart:io';

import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
  late String imageType = '';

  @override
  void initState() {
    super.initState();
    initCamera();

    // show guide popup
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        barrierColor: Colors.black87,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.65,
            child: IntroductionScreen(
              rawPages: const [
                GuidePage(
                  title: '스마트 등록이란?',
                  body:
                      '영수증이나 온라인 구매 내역 사진을\n업로드하면 쉽고 빠른 등록이 가능해요.\n등록할 식품이 많아도 걱정 없어요!\n\n(지원 형식: 영수증, 마켓컬리 주문내역)',
                ),
                GuidePage(
                  title: '영수증',
                  imagePath: 'assets/images/크롭가이드_영수증.png',
                  body: '영수증을 빳빳하게 편 다음\n글자가 잘 보이도록 촬영하고\n상품 목록 전체를 포함하여 잘라주세요',
                ),
                GuidePage(
                  title: '온라인 구매 내역',
                  imagePath: 'assets/images/크롭가이드_마켓컬리주문내역.png',
                  body: '온라인 구매 내역을 캡처한 후\n사진을 제외한 상품 목록을\n구분선에 맞추어 잘라주세요',
                ),
              ],
              showNextButton: true,
              showDoneButton: true,
              next: const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: ColorStyles.textColor,
                ),
              ),
              done: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '확인',
                  style: TextStyle(
                    color: ColorStyles.textColor,
                  ),
                ),
              ),
              onDone: () {
                Navigator.of(context).pop();
              },
              baseBtnStyle: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 4)),
              ),
              dotsDecorator: const DotsDecorator(
                size: Size(10, 10),
                activeSize: Size(25.0, 10.0),
                activeColor: ColorStyles.mainColor,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
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
      compressQuality: 100,
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

class GuidePage extends StatelessWidget {
  final String title;
  final String? imagePath;
  final String body;

  const GuidePage({
    super.key,
    required this.title,
    this.imagePath,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: ColorStyles.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (imagePath != null)
            Center(
              child: Image.asset(
                imagePath!,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.32,
              ),
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 30),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                body,
                style: const TextStyle(
                  color: ColorStyles.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
