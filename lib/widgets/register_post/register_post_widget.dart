import 'dart:io';

import 'package:brainstorm_meokjang/utilities/Colors.dart';
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
                    color: ColorStyles.mainColor, fontSize: 24, fontWeight: FontWeight.bold),
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
  const TitleInput({super.key});

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
                hintStyle: const TextStyle(fontSize: 14, color: ColorStyles.hintTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: ColorStyles.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: ColorStyles.borderColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpirationDateInput extends StatefulWidget {
  const ExpirationDateInput({super.key});

  @override
  State<ExpirationDateInput> createState() => _ExpirationDateInputState();
}

class _ExpirationDateInputState extends State<ExpirationDateInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "남은 소비기한",
                style: TextStyle(
                  color: ColorStyles.black,
                ),
              ),
            ),
            // FoodExpireDate(
            //     expireDate: DateTime.now(), setExpireDate: DateTime.now()),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: '2023-05-26',
                      hintStyle: const TextStyle(fontSize: 14, color: ColorStyles.hintTextColor),
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
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month_outlined),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumOfPeopleInput extends StatefulWidget {
  const NumOfPeopleInput({super.key});

  @override
  State<NumOfPeopleInput> createState() => _NumOfPeopleInputState();
}

class _NumOfPeopleInputState extends State<NumOfPeopleInput> {
  final _values = ['선택', '2명', '3명', '4명', '5명', '6명', '7명', '8명', '9명', '10명'];
  String _selectedValue = '선택';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "인원 수",
                style: TextStyle(color: ColorStyles.black),
              ),
            ),
            SizedBox(
              width: 120,
              height: 55,
              child: DropdownButtonFormField(
                value: _selectedValue,
                items: _values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value!;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: ColorStyles.borderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: ColorStyles.borderColor,
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

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({super.key});

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
                  hintStyle: const TextStyle(fontSize: 12, color: ColorStyles.hintTextColor),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoBoxInput extends StatefulWidget {
  const PhotoBoxInput({super.key});

  @override
  State<PhotoBoxInput> createState() => _PhotoBoxInputState();
}

class _PhotoBoxInputState extends State<PhotoBoxInput> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);

        print(_image.hashCode);
      });
    }
  }

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
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorStyles.borderColor, width: 1.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: ColorStyles.borderColor,
                                                width: 2),
                                          ),
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  getImage(ImageSource.camera);
                                                },
                                                icon: const Icon(
                                                    Icons.camera_alt_outlined),
                                              ),
                                              const Text("카메라"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: ColorStyles.borderColor,
                                                width: 2),
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
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorStyles.borderColor, width: 1.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorStyles.borderColor, width: 1.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorStyles.borderColor, width: 1.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

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
              onPressed: () => Navigator.of(context).pop(),
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
