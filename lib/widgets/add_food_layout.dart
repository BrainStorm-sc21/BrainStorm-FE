import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';

/// 식품 등록 화면 레이아웃
/// 구조: 배경, 제목, 내용(식품정보), 버튼
class AddFoodLayout extends StatelessWidget {
  final String title;
  final Color containerColor;
  final Widget child;

  const AddFoodLayout({
    super.key,
    required this.title,
    this.containerColor = const Color.fromRGBO(249, 249, 249, 1.0),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 그라데이션 배경
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(35, 204, 135, 1.0), Colors.cyan]),
            ),
          ),
        ),
        // 제목
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: SizedBox(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // 식품 정보 및 버튼 컨테이너
        Positioned(
          top: 180,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 식품 정보 박스
                  child,
                  // 등록/취소 버튼
                  Column(
                    children: [
                      // '등록하기' 버튼
                      RoundedOutlinedButton(
                        text: '등록하기',
                        onPressed: () => register(),
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromRGBO(35, 204, 135, 1.0),
                        borderColor: const Color.fromRGBO(35, 204, 135, 1.0),
                      ),
                      // '취소하기' 버튼
                      RoundedOutlinedButton(
                        text: '취소하기',
                        onPressed: () => cancel(),
                        foregroundColor:
                            const Color.fromRGBO(35, 204, 135, 1.0),
                        backgroundColor: Colors.white,
                        borderColor: const Color.fromRGBO(35, 204, 135, 1.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void cancel() => debugPrint('pressed cancel');

  void register() => debugPrint('pressed add');
}
