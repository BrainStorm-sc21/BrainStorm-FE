import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class TopPostUnit extends StatefulWidget {
  final String nickname;
  final String distance;

  const TopPostUnit({
    super.key,
    this.nickname = '삼식이 네끼',
    this.distance = '300M',
  });

  @override
  State<TopPostUnit> createState() => _TopPostUnitState();
}

class _TopPostUnitState extends State<TopPostUnit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 25),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Column(
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
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
