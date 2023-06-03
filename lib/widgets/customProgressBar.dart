import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomProgressBar extends StatelessWidget {
  final double maxPercent;
  final double currentPercent;
  final double lineHeight;
  final double radius;
  final Color backgroundColor;
  final Color firstColor;
  final Color secondColor;
  final double paddingVertical;
  final double paddingHorizontal;

  const CustomProgressBar(
      {super.key,
      required this.maxPercent,
      required this.currentPercent,
      this.lineHeight = 10.0,
      this.radius = 16.0,
      this.backgroundColor = ColorStyles.lightgrey,
      this.firstColor = ColorStyles.expireRedColor,
      this.secondColor = ColorStyles.expireOrangeColor,
      this.paddingVertical = 10.0,
      this.paddingHorizontal = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      child: LinearPercentIndicator(
        padding: const EdgeInsets.all(0),
        lineHeight: lineHeight,
        percent: currentPercent / maxPercent,
        barRadius: Radius.circular(radius),
        backgroundColor: backgroundColor,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [firstColor, secondColor],
        ),
      ),
    );
  }
}
