import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;

  const RoundedOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 50,
    this.height = 35,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width, height),
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        side: BorderSide(
          color: borderColor,
          width: 1.5,
        ),
        textStyle: TextStyle(fontSize: fontSize),
      ),
      child: Text(text),
    );
  }
}
