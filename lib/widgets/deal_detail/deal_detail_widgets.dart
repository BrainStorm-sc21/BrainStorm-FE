import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/profile/others_profile_page.dart';
import 'package:brainstorm_meokjang/utilities/Popups.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TopPostUnit extends StatefulWidget {
  final String nickname;
  final String distance;
  final double reliability;
  final bool isMine;
  final int dealId;
  final int reviewFrom;
  final Deal deal;

  const TopPostUnit({
    super.key,
    required this.nickname,
    required this.distance,
    required this.reliability,
    required this.isMine,
    required this.dealId,
    required this.reviewFrom,
    required this.deal,
  });

  @override
  State<TopPostUnit> createState() => _TopPostUnitState();
}

class _TopPostUnitState extends State<TopPostUnit> {
  late List<dynamic> keyList = [];
  late List<dynamic> valueList = [];

  Future requestChatUserList() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      Response resp = await dio.get("/deal/${widget.dealId}/complete");

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

  void requestCompleteDeal() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    print("딜 아이디: ${widget.dealId}");

    try {
      final resp = await dio.put('deal/${widget.dealId}/complete');
      print("Modify Status: ${resp.statusCode}");

      //Navigator.pop(context);

      if (resp.statusCode == 200) {
        showToast('해당 거래가 완료되었습니다');
      } else {
        print('??');
      }
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

  @override
  void initState() {
    super.initState();
    requestChatUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OthersProfile(
                            ownerId: widget.deal.userId,
                            userName: widget.deal.userName!,
                            reliability: widget.deal.reliability!,
                          )),
                ),
                child: Text(
                  widget.nickname,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: ColorStyles.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.distance,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const Spacer(),
          (widget.isMine)
              ? OutlinedButton(
                  onPressed: () {
                    (keyList.isEmpty)
                        ? showToast('아직 거래 참여자가 없습니다!')
                        : Popups.showParticipantList(
                            context, widget.dealId, widget.reviewFrom);
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ColorStyles.mainColor)),
                  child: const Text(
                    '거래완료',
                    style: TextStyle(
                      color: ColorStyles.mainColor,
                      fontSize: 14,
                    ),
                  ),
                )
              : SizedBox(
                  width: 65,
                  height: 50,
                  child: Column(
                    children: [
                      Container(
                        // alignment:
                        //     const FractionalOffset(60 / 100, 1 - (60 / 100)),
                        child: FractionallySizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('신뢰도 ${widget.reliability.toInt()}',
                                  style: const TextStyle(
                                    color: ColorStyles.mainColor,
                                    fontSize: 14,
                                  )),
                              //const SizedBox(height: 3),
                              // Image.asset(
                              //     'assets/images/inverted_triangle1.png'),
                            ],
                          ),
                        ),
                      ),
                      CustomProgressBar(
                        paddingHorizontal: 2,
                        currentPercent: widget.reliability,
                        maxPercent: 100,
                        lineHeight: 8,
                        firstColor: ColorStyles.mainColor,
                        secondColor: ColorStyles.mainColor,
                      ),
                    ],
                  ),
                ),
        ]),
      ),
    );
  }

  //Regrigerator의 다이얼로그를 활용
  void showCompleteDealDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("거래를 완료하시겠습니까?"),
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
                  requestCompleteDeal();
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
