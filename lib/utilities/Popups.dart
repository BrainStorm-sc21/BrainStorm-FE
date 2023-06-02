import 'package:brainstorm_meokjang/pages/deal/detail/deal_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/go_to_post/go_to_post_widgets.dart';
import 'package:brainstorm_meokjang/pages/home/ocr_result_page.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Popups {
  static void popSimpleDialog(
    context, {
    required title,
    required body,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: ColorStyles.black),
          ),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                '확인',
                style: TextStyle(color: ColorStyles.textColor),
              ),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        );
      },
    );
  }

  // static void checkSignUp(context, type) {
  //   showDialog(context: context, builder: (context) {
  //     return Dialog(
  //       shape: ,
  //     )
  //   });
  // }
  static void showReview(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    '거래 후기',
                    style: TextStyle(
                        color: ColorStyles.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  const StarPointUnit(),
                  SizedBox(
                    width: 230,
                    height: 130,
                    child: TextFormField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: '거래에 대한 간단한 후기를 남겨주세요!',
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
                    ),
                  ),
                  const Spacer(),
                  RoundedOutlinedButton(
                      width: 230,
                      height: 28,
                      text: '보내기',
                      onPressed: () {},
                      backgroundColor: ColorStyles.mainColor,
                      foregroundColor: ColorStyles.white,
                      borderColor: ColorStyles.mainColor),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
  }

  static void goToPost(context, userId, deal, isMine) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: width * 0.8,
            height: height * 0.65,
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.25,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: deal.dealImage1 != null
                          ? Image.network(deal.dealImage1, fit: BoxFit.fill)
                          : Image.asset('assets/images/logo.png',
                              fit: BoxFit.fill),
                    ),
                  ),
                  firstPostUnit(deal: deal),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      color: Colors.grey[350],
                      height: 0.5,
                      width: double.infinity,
                    ),
                  ),
                  secondPostUnit(
                    deal: deal,
                  ),
                  const Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: SizedBox(
                      child: Column(
                        children: [
                          RoundedOutlinedButton(
                            text: '게시글로 이동',
                            width: double.infinity,
                            height: 35,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DealDetailPage(
                                            userId: userId,
                                            deal: deal,
                                            isMine: isMine,
                                          )));
                            },
                            foregroundColor: ColorStyles.white,
                            backgroundColor: ColorStyles.mainColor,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 스마트 등록에서 이미지 submit 시 이미지 유형을 선택
  static void selectImageType(context, croppedFile, int userId) {
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
                      userId: userId,
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
                      userId: userId,
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

  static void showSmartAddGuide(context) async {
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
                imagePath: 'assets/images/crop_guide_document.png',
                body: '영수증을 빳빳하게 편 다음\n글자가 잘 보이도록 촬영하고\n상품 목록 전체를 포함하여 잘라주세요',
              ),
              GuidePage(
                title: '온라인 구매 내역',
                imagePath: 'assets/images/crop_guide_general_kurly.png',
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

class StarPointUnit extends StatefulWidget {
  const StarPointUnit({super.key});

  @override
  State<StarPointUnit> createState() => _StarPointUnitState();
}

class _StarPointUnitState extends State<StarPointUnit> {
  List<bool> isHighlight = [false, false, false, false, false];

  void setHighlight(idx) {
    // setState(() {
    //   int tmp = 0;
    //   for (bool ele in isHighlight) {
    //     ele = (tmp <= idx);
    //     print('isHighlight[$tmp] = $ele');
    //     tmp += 1;
    //   }
    // });
    switch (idx) {
      case 0:
        setState(() {
          isHighlight[0] = true;
          isHighlight[1] = false;
          isHighlight[2] = false;
          isHighlight[3] = false;
          isHighlight[4] = false;
        });
        return;
      case 1:
        setState(() {
          isHighlight[0] = true;
          isHighlight[1] = true;
          isHighlight[2] = false;
          isHighlight[3] = false;
          isHighlight[4] = false;
        });
        return;
      case 2:
        setState(() {
          isHighlight[0] = true;
          isHighlight[1] = true;
          isHighlight[2] = true;
          isHighlight[3] = false;
          isHighlight[4] = false;
        });
        return;
      case 3:
        setState(() {
          isHighlight[0] = true;
          isHighlight[1] = true;
          isHighlight[2] = true;
          isHighlight[3] = true;
          isHighlight[4] = false;
        });
        return;
      case 4:
        setState(() {
          isHighlight[0] = true;
          isHighlight[1] = true;
          isHighlight[2] = true;
          isHighlight[3] = true;
          isHighlight[4] = true;
        });
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        width: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return IconButton(
              color: (isHighlight[index])
                  ? ColorStyles.mainColor
                  : ColorStyles.grey,
              onPressed: () {
                print('클릭한 인덱스: $index');
                setHighlight(index);
              },
              icon: const Icon(Icons.star),
            );
          },
        ));
  }
}
