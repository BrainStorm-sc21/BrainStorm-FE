import 'dart:io';

import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TopBar extends StatelessWidget {
  final String title;
  final String subTitle;
  final double width;
  final double height;

  const TopBar({
    super.key,
    this.title = "공동구매하기",
    this.subTitle = "묶음으로만 파는 식재료를\n이웃과 공동구매해요",
    this.width = double.infinity,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(color: ColorStyles.borderColor, width: 1.0),
        )),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                title,
                style: const TextStyle(
                    color: ColorStyles.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, bottom: 15),
              child: Text(
                subTitle,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleInput extends StatelessWidget {
  final void Function(String value) setTitle;
  const TitleInput({super.key, required this.setTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "제목",
                style: TextStyle(color: ColorStyles.black),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "게시글 제목을 입력해주세요",
                hintStyle: const TextStyle(
                    fontSize: 14, color: ColorStyles.hintTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: ColorStyles.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: ColorStyles.borderColor),
                ),
              ),
              onChanged: (value) => setTitle(value),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionInput extends StatelessWidget {
  final void Function(String value) setContent;
  const DescriptionInput({super.key, required this.setContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "상세설명",
                style: TextStyle(color: ColorStyles.black),
              ),
            ),
            Container(
              child: TextFormField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText:
                      '상세 내용에는 아래의 내용들을 포함시켜 작성해주세요.\n\n - 식재료 명\n - 거래 장소\n - 거래 식재료의 간단한 소개',
                  hintStyle: const TextStyle(
                      fontSize: 12, color: ColorStyles.hintTextColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: ColorStyles.borderColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: ColorStyles.borderColor,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (value) => setContent(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoBoxInput extends StatefulWidget {
  final void Function(
      String? image1, String? image2, String? image3, String? image4) setImages;
  const PhotoBoxInput({super.key, required this.setImages});

  @override
  State<PhotoBoxInput> createState() => _PhotoBoxInputState();
}

class _PhotoBoxInputState extends State<PhotoBoxInput> {
  late List<String?> images = [null, null, null, null];

  void setImage(int idx, String image) => setState(() {
        images[idx] = image;
        widget.setImages(images[0], images[1], images[2], images[3]);
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "사진 등록",
                style: TextStyle(color: ColorStyles.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PhotoboxUnit(index: 0, setImage: setImage),
                PhotoboxUnit(index: 1, setImage: setImage),
                PhotoboxUnit(index: 2, setImage: setImage),
                PhotoboxUnit(index: 3, setImage: setImage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoboxUnit extends StatefulWidget {
  final int index;
  final void Function(int idx, String image) setImage;
  const PhotoboxUnit({super.key, required this.index, required this.setImage});

  @override
  State<PhotoboxUnit> createState() => _PhotoboxUnitState();
}

class _PhotoboxUnitState extends State<PhotoboxUnit> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
        widget.setImage(widget.index, _image!.path);
        print(_image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: ColorStyles.borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: _image == null
          ? IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 150,
                      color: ColorStyles.transparent,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: ColorStyles.borderColor, width: 2),
                              ),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      getImage(ImageSource.camera);
                                    },
                                    icon: const Icon(Icons.camera_alt_outlined),
                                  ),
                                  const Text("카메라"),
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: ColorStyles.borderColor, width: 2),
                              ),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      getImage(ImageSource.gallery);
                                    },
                                    icon: const Icon(Icons.photo),
                                  ),
                                  const Text("갤러리"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                File(_image!.path),
                fit: BoxFit.fill,
              ),
            ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final VoidCallback registerPost;
  const BottomButton({
    super.key,
    required this.registerPost,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: SizedBox(
        child: Column(
          children: [
            // '등록하기' 버튼
            RoundedOutlinedButton(
              text: '등록하기',
              width: double.infinity,
              onPressed: registerPost,
              foregroundColor: ColorStyles.white,
              backgroundColor: ColorStyles.mainColor,
              borderColor: ColorStyles.mainColor,
              fontSize: 18,
            ),
            // '취소하기' 버튼
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RoundedOutlinedButton(
                text: '취소하기',
                width: double.infinity,
                onPressed: () => Navigator.of(context).pop(),
                foregroundColor: ColorStyles.mainColor,
                backgroundColor: ColorStyles.white,
                borderColor: ColorStyles.mainColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
