import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ProfileListItem({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 0),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: ColorStyles.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
