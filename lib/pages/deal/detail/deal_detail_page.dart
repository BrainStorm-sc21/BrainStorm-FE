import 'package:brainstorm_meokjang/app_pages_container.dart';
import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/chat/chat_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/deal_detail/deal_detail_widgets.dart';
import 'package:brainstorm_meokjang/widgets/go_to_post/go_to_post_widgets.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DealDetailPage extends StatefulWidget {
  final int userId;
  final Deal deal;
  final bool isMine;

  const DealDetailPage({
    super.key,
    required this.userId,
    required this.deal,
    required this.isMine,
  });

  @override
  State<DealDetailPage> createState() => _DealDetailPageState();
}

class _DealDetailPageState extends State<DealDetailPage> {
  List<String> imageList = [];

  void setImageList() {
    if (widget.deal.dealImage1 != null) {
      imageList.add(widget.deal.dealImage1!);
    }
    if (widget.deal.dealImage2 != null) {
      imageList.add(widget.deal.dealImage2!);
    }
    if (widget.deal.dealImage3 != null) {
      imageList.add(widget.deal.dealImage3!);
    }
    if (widget.deal.dealImage4 != null) {
      imageList.add(widget.deal.dealImage4!);
    }
  }

  void deleteDeal(int dealId) async {
    print('deleteDeal 호출');
    print('dealId: $dealId');
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      final resp = await dio.delete("/deal/$dealId");
      print("Delete Status: ${resp.statusCode}");

      if (resp.data['status'] == 200) {
        print('삭제 성공!');
      } else {
        print('??');
      }
    } catch (e) {
      Exception(e);
      print(e);
    } finally {
      dio.close();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setImageList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.3,
                color: Colors.grey[300],
                child: (imageList.isEmpty)
                    ? null
                    : PageView.builder(
                        controller: PageController(initialPage: 0),
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: Image.network(
                            imageList[index],
                            fit: BoxFit.fill,
                          ));
                        },
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            width: width,
            height: (imageList.isEmpty) ? height * 0.87 : height * 0.72,
            child: Column(
              children: [
                TopPostUnit(
                  distance: '${widget.deal.distance?.round()}m',
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 10),
                  child: Container(
                    color: Colors.grey[350],
                    height: 0.5,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: firstPostUnit(
                    deal: widget.deal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(widget.deal.dealContent),
                    ),
                  ),
                ),
                const Spacer(),
                (widget.isMine)
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 40),
                        child: Column(
                          children: [
                            RoundedOutlinedButton(
                                width: double.infinity,
                                height: 40,
                                text: '수정하기',
                                onPressed: () {},
                                backgroundColor: ColorStyles.mainColor,
                                foregroundColor: ColorStyles.white,
                                borderColor: ColorStyles.mainColor),
                            const SizedBox(height: 10),
                            RoundedOutlinedButton(
                                width: double.infinity,
                                height: 40,
                                text: '삭제하기',
                                onPressed: () {
                                  showDeleteDealDialog();
                                },
                                backgroundColor: ColorStyles.white,
                                foregroundColor: ColorStyles.mainColor,
                                borderColor: ColorStyles.mainColor)
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 40),
                        child: RoundedOutlinedButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatDetailPage(
                                senderId: widget.userId,
                                receiverId: widget.deal.userId,
                                deal: widget.deal,
                              ),
                            ),
                          ),
                          text: '채팅하기',
                          width: double.infinity,
                          height: 40,
                          backgroundColor: ColorStyles.mainColor,
                          foregroundColor: ColorStyles.white,
                          borderColor: ColorStyles.mainColor,
                        ),
                      )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  //Regrigerator의 다이얼로그를 활용
  void showDeleteDealDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("정말로 삭제하시겠습니까?"),
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
                onPressed: () {
                  deleteDeal(widget.deal.dealId!);
                  showToast('게시글이 삭제되었습니다');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppPagesContainer(
                          index: AppPagesNumber.deal, userId: widget.userId),
                    ),
                    (route) => false,
                  );
                  //Navigator.pop(context);
                },
                child: const Text(
                  "확인",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          );
        });
  }
}
