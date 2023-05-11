import 'package:flutter/material.dart';

class OutlineCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final double radius;
  final double borderSize;
  final Color borderColor;
  final Color foregroundColor;
  final Icon child;

  const OutlineCircleButton({
    super.key,
    required this.onTap,
    this.borderSize = 0.5,
    this.radius = 20.0,
    this.borderColor = Colors.black,
    this.foregroundColor = Colors.white,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderSize),
          color: foregroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              child: child,
              onTap: () {
                onTap;
              }),
        ),
      ),
    );
  }
}
