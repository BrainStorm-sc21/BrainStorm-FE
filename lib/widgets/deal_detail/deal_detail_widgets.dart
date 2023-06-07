import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:flutter/material.dart';

class TopPostUnit extends StatefulWidget {
  final String nickname;
  final String distance;
  final bool isMine;

  const TopPostUnit({
    super.key,
    this.nickname = '삼식이 네끼',
    this.distance = '300M',
    required this.isMine,
  });

  @override
  State<TopPostUnit> createState() => _TopPostUnitState();
}

class _TopPostUnitState extends State<TopPostUnit> {
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
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      foregroundColor: ColorStyles.grey),
                  child: const Text(
                    '거래완료하기',
                    style: TextStyle(fontSize: 14),
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
                              Text('신뢰도 ${60.toString()}',
                                  style: const TextStyle(
                                    color: ColorStyles.lightYellow,
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
                        firstColor: ColorStyles.lightYellow,
                        secondColor: ColorStyles.lightYellow,
                      ),
                    ],
                  ),
                ),
        ]),
      ),
    );
  }
}
