import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;

  const RoundedOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 35),
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
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(text),
    );
  }
}
