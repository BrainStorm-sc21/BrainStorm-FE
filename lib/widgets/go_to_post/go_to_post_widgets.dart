import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class firstPostUnit extends StatefulWidget {
  final String type;
  final String title;
  final String time;

  const firstPostUnit(
      {super.key,
      this.type = '공구',
      this.title = '감자 공동구매 하실 분!',
      this.time = '1시간 전'});

  @override
  State<firstPostUnit> createState() => _firstPostUnitState();
}

class _firstPostUnitState extends State<firstPostUnit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 16),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 37,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorStyles.groupBuyColor),
                  child: Center(
                      child: Text(widget.type,
                          style: const TextStyle(
                              fontSize: 11, color: Colors.purple))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(widget.title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ColorStyles.black)),
                ),
              ],
            ),
            Text(
              widget.time,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class secondPostUnit extends StatefulWidget {
  final String nickname;
  final String distance;
  final String description;

  const secondPostUnit(
      {super.key,
      this.nickname = '삼식이 네끼',
      this.distance = '300M',
      this.description =
          '국산 햇감자 공동구매하실분 찾습니다!!\n아는분께서 감자농사 하시는데 박스 단위로 판매하시...'});

  @override
  State<secondPostUnit> createState() => _secondPostUnitState();
}

class _secondPostUnitState extends State<secondPostUnit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(widget.nickname,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorStyles.black)),
                ),
                Text(widget.distance,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                widget.description,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
