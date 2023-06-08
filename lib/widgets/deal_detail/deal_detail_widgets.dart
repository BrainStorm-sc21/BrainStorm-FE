import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TopPostUnit extends StatefulWidget {
  final String nickname;
  final String distance;
  final bool isMine;
  final int dealId;

  const TopPostUnit({
    super.key,
    this.nickname = '삼식이 네끼',
    this.distance = '300M',
    required this.isMine,
    required this.dealId,
  });

  @override
  State<TopPostUnit> createState() => _TopPostUnitState();
}

class _TopPostUnitState extends State<TopPostUnit> {
  void requestCompleteDeal() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      final resp = await dio.put("deal/${widget.dealId}/complete");

      if (resp.statusCode == 200) {
        print('거래 완료 성공!');
        showToast('해당 거래가 완료되었습니다');
        Navigator.pop(context);
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
              Text(
                widget.nickname,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ColorStyles.black),
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
                    showCompleteDealDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                      foregroundColor: ColorStyles.grey),
                  child: const Text(
                    '거래완료하기',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : SizedBox(
                  //color: Colors.grey.shade50,
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
                              Text('신뢰도 ${60.toString()}',
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
                      const CustomProgressBar(
                        paddingHorizontal: 2,
                        currentPercent: 60,
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
