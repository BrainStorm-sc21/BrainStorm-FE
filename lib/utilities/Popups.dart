import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/models/review.dart';
import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/pages/deal/detail/deal_detail_page.dart';
import 'package:brainstorm_meokjang/pages/start/signup_page.dart';
import 'package:brainstorm_meokjang/providers/userInfo_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/go_to_post/go_to_post_widgets.dart';
import 'package:brainstorm_meokjang/pages/home/ocr_result_page.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

//Regrigerator의 다이얼로그를 활용
  static void showCustomDialog(title, clickAction, context) async {
    VoidCallback onPressed = clickAction;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(title),
            actions: [
              // 취소 버튼
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("취소"),
              ),
              // 확인 버튼
              TextButton(
                onPressed: () => onPressed,
                child: const Text(
                  "확인",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          );
        });
  }

  static void showReportDialog(
    context, {
    required reporterId,
    required reportedUserId,
  }) {
    late String content = '';

    // on reported
    void onReported() async {
      debugPrint('Press report button !');
      debugPrint(content);

      Dio dio = Dio();
      dio.options
        ..baseUrl = baseURI
        ..connectTimeout = const Duration(seconds: 5)
        ..receiveTimeout = const Duration(seconds: 10);

      final data = {
        "reporter": reporterId,
        "reportedUser": reportedUserId,
        "content": content,
      };

      debugPrint('report data: $data');

      try {
        final res = await dio.post(
          '/report',
          data: data,
        );
        debugPrint('${res.data}');
      } catch (e) {
        debugPrint('$e');
      } finally {
        dio.close();
      }
      return Navigator.of(context).pop();
    }

    // show report dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: ColorStyles.white,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.42,
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        '신고',
                        style: TextStyle(
                          color: ColorStyles.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) => content = value,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText:
                        '신고할 내용에 대해 입력해주세요.\n다른 사용자를 허위로 신고하는 경우 제재 대상이 될 수 있습니다.',
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
                const SizedBox(height: 20),
                RoundedOutlinedButton(
                  width: double.infinity,
                  text: '신고하기',
                  onPressed: onReported,
                  foregroundColor: ColorStyles.white,
                  backgroundColor: ColorStyles.errorRed,
                  borderColor: ColorStyles.errorRed,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void showParticipantList(context, dealId, reviewFrom) async {
    late List<dynamic> keyList = [];
    late List<dynamic> valueList = [];

    int reviewTo = -1;

    void setReviewTo(int value) {
      reviewTo = value;
    }

    Future requestChatUserList() async {
      Dio dio = Dio();
      dio.options
        ..baseUrl = baseURI
        ..connectTimeout = const Duration(seconds: 5)
        ..receiveTimeout = const Duration(seconds: 10);

      try {
        final resp = await dio.get("/deal/$dealId/complete");

        keyList = resp.data['data'].keys.toList();
        valueList = resp.data['data'].values.toList();
        print(keyList);
        print(valueList);
      } catch (e) {
        Exception(e);
      } finally {
        dio.close();
      }
    }

    await requestChatUserList();

    (keyList.isEmpty)
        ? showToast('아직 거래 참여자가 없습니다!')
        : showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  width: 250,
                  height: (keyList.length + 1) * 40 + 110,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const Text(
                        '거래 참여자 목록',
                        style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 30, left: 5, right: 5),
                          child: (keyList.isNotEmpty)
                              ? SizedBox(
                                  width: 240,
                                  height: (keyList.length + 1) * 40,
                                  child: ListView.builder(
                                      itemCount: keyList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return ParticipantUnit(
                                          userName: valueList[index],
                                          userId: int.parse(keyList[index]),
                                          //userId: keyList[index],
                                          setReviewTo: setReviewTo,
                                        );
                                      }),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text(
                                      '아직 거래 참여자가 없습니다!\n',
                                      style: TextStyle(
                                          color: ColorStyles.mainColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RoundedOutlinedButton(
                            width: 230,
                            height: 28,
                            text: '거래완료',
                            onPressed: () {
                              if (reviewTo == -1) {
                                showToast('거래 참여자를 선택해주세요!');
                                return;
                              }
                              print('거래완료 시도');
                              print('거래완료한 상대 사용자 아이디: $reviewTo');
                              requestCompleteDeal(dealId);
                              //print('거래완료 완료');
                              Navigator.of(context).pop();
                              showReview(context, dealId, reviewFrom, reviewTo);
                            },
                            backgroundColor: (reviewTo == -1)
                                ? ColorStyles.mainColor
                                : ColorStyles.grey,
                            foregroundColor: ColorStyles.white,
                            borderColor: (reviewTo == -1)
                                ? ColorStyles.mainColor
                                : ColorStyles.grey),
                      )
                    ],
                  ),
                ),
              );
            });
  }

  static void showReview(context, dealId, reviewFrom, reviewTo) {
    double reviewPoint = 0;
    String? reviewContents;
    late Review review;

    void setPoint(double point) {
      reviewPoint = point;
    }

    Future requestSendReview() async {
      Dio dio = Dio();
      dio.options
        ..baseUrl = baseURI
        ..connectTimeout = const Duration(seconds: 5)
        ..receiveTimeout = const Duration(seconds: 10);

      final data = review.toJson();

      print('리뷰 데이터: $data');
      print('딜아이디: $dealId');

      try {
        final resp = await dio.post('/review/$dealId', data: data);

        print('리스폰스 데이터: ${resp.data}');

        if (resp.statusCode == 200) {
          print('리뷰 등록에 성공했습니다!');
          showToast('리뷰를 보냈습니다!');
          Navigator.pop(context);
        } else {
          print('엥 왜 실패했지');
        }
      } catch (e) {
        Exception(e);
      } finally {
        dio.close();
      }
    }

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
                  StarPointUnit(
                    setPoint: setPoint,
                  ),
                  SizedBox(
                    width: 230,
                    height: 130,
                    child: TextFormField(
                      onChanged: (value) {
                        reviewContents = value;
                      },
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
                      onPressed: () {
                        review = Review(
                            reviewFrom: reviewFrom,
                            reviewTo: reviewTo,
                            dealId: dealId,
                            rating: reviewPoint,
                            reviewContent: reviewContents);

                        requestSendReview();
                        print('리뷰점수: $reviewPoint');
                        print('리뷰컨텐츠: $reviewContents');
                        print('$reviewFrom 이 3 에게 리뷰를 보냅니다');
                      },
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

  static void changeUserInfo(context, userId) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final UserInfoController userInfoController = Get.put(UserInfoController());
    final User info = User(
        userName: userInfoController.userName,
        location: '',
        latitude: 0,
        longitude: 0);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textController =
        TextEditingController(text: userInfoController.userName);

    void setName(String value) => (info.userName = value);

    void setAddress(String location, double latitude, double longitude) {
      info.location = location;
      info.latitude = latitude;
      info.longitude = longitude;
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            width: width * 0.8,
            height: height * 0.6,
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "닉네임",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: '닉네임을 입력하세요',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2, color: ColorStyles.mainColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2, color: ColorStyles.mainColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2, color: ColorStyles.errorRed),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2, color: ColorStyles.errorRed),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '값을 입력해주세요.';
                          } else if (value.startsWith(' ')) {
                            return '올바른 값을 입력해주세요.';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (value) => setName(value),
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(), // 키보드 숨김
                      ),
                    ),
                    PositionField(setAddress: setAddress),
                    const Spacer(),
                    SizedBox(
                      child: Column(
                        children: [
                          RoundedOutlinedButton(
                            text: '수정하기',
                            width: double.infinity,
                            onPressed: () {
                              final data = {
                                "userName": info.userName,
                              };
                              userInfoController.modifyUserInfo(userId, data);
                              Navigator.of(context).pop();
                            },
                            foregroundColor: ColorStyles.white,
                            backgroundColor: ColorStyles.mainColor,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                          const SizedBox(height: 10),
                          RoundedOutlinedButton(
                            text: '취소하기',
                            width: double.infinity,
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
  final void Function(double point) setPoint;
  const StarPointUnit({super.key, required this.setPoint});

  @override
  State<StarPointUnit> createState() => _StarPointUnitState();
}

class _StarPointUnitState extends State<StarPointUnit> {
  List<bool> isHighlight = [false, false, false, false, false];
  int reviewPoint = 0;

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
                widget.setPoint(index + 1);
              },
              icon: const Icon(Icons.star),
            );
          },
        ));
  }
}

class ParticipantUnit extends StatefulWidget {
  final String userName;
  final int userId;
  final void Function(int value) setReviewTo;
  const ParticipantUnit(
      {super.key,
      required this.userName,
      required this.userId,
      required this.setReviewTo});

  @override
  State<ParticipantUnit> createState() => _ParticipantUnitState();
}

class _ParticipantUnitState extends State<ParticipantUnit> {
  bool isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: 240,
        height: 40,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                  width: 1,
                  color:
                      (isClicked) ? ColorStyles.mainColor : ColorStyles.grey)),
          onPressed: buttonClicked,
          child: Text(widget.userName,
              style: const TextStyle(color: ColorStyles.black)),
        ),
      ),
    );
  }

  void buttonClicked() {
    setState(() {
      if (isClicked == false) {
        isClicked = true;
        widget.setReviewTo(widget.userId);
      } else {
        isClicked = false;
        widget.setReviewTo(-1);
      }
      //isClicked != isClicked;
    });
  }
}
