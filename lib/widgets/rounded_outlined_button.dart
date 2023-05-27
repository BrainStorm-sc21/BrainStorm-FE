import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderwidth;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;
  final double radius;

  const RoundedOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 50,
    this.height = 35,
    this.borderwidth = 1.5,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.fontSize = 16,
    this.radius = 50,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(Size(width, height)),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: borderColor,
            width: borderwidth,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: fontSize, height: 1),
        ),
      ),
      child: Text(text),
    );
  }
}
