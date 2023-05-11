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
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(Size(width, height)),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: borderColor,
            width: 1.5,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: fontSize),
        ),
      ),
      child: Text(text),
    );
  }
}
