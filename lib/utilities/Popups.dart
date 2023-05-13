import 'package:brainstorm_meokjang/pages/home/ocr_result_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class Popups {
  static void goToPost(context, type) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: Text(
                        type,
                        style: const TextStyle(
                            fontSize: 24,
                            color: ColorStyles.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: ColorStyles.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Column(
                        children: [
                          RoundedOutlinedButton(
                            text: '게시글로 이동',
                            width: double.infinity,
                            height: 35,
                            onPressed: () => Navigator.of(context).pop(),
                            foregroundColor: ColorStyles.white,
                            backgroundColor: ColorStyles.mainColor,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                          RoundedOutlinedButton(
                            text: '나가기',
                            width: double.infinity,
                            height: 35,
                            onPressed: () => Navigator.of(context).pop(),
                            foregroundColor: ColorStyles.mainColor,
                            backgroundColor: ColorStyles.white,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // 스마트 등록에서 이미지 submit 시 이미지 유형을 선택
  static void selectImageType(context, croppedFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            '사진 유형을 선택해주세요',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => OCRResultPage(
                      imagePath: croppedFile!.path,
                      imageType: 'document',
                    ),
                  ),
                );
              },
              child: const Text('영수증'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => OCRResultPage(
                      imagePath: croppedFile!.path,
                      imageType: 'general',
                    ),
                  ),
                );
              },
              child: const Text('마켓컬리 구매내역'),
            ),
          ],
        );
      },
    );
  }
}
