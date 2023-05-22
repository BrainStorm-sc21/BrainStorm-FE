import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomProgressBar extends StatelessWidget {
  final int maxPercent;
  final int currentPercent;
  final double radius;
  final Color backgroundColor;
  final Color firstColor;
  final Color secondColor;

  const CustomProgressBar(
      {super.key,
      required this.maxPercent,
      required this.currentPercent,
      this.radius = 16.0,
      this.backgroundColor = ColorStyles.lightgrey,
      this.firstColor = ColorStyles.expireRedColor,
      this.secondColor = ColorStyles.expireOrangeColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LinearPercentIndicator(
        padding: const EdgeInsets.all(0),
        lineHeight: 10.0,
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
