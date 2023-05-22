import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hinttext;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double borderRadius;
  final double borderwidth;
  final Color fillColor;
  final Color borderColor;
  final Color hintTextColor;
  final double fontSize;

  final TextEditingController textEditingController;

  const CustomSearchBar({
    super.key,
    this.hinttext = '',
    required this.onTap,
    this.width = 50,
    this.height = 40,
    this.borderRadius = 40,
    this.borderwidth = 1.5,
    this.fillColor = ColorStyles.transparent,
    required this.borderColor,
    this.hintTextColor = ColorStyles.hintTextColor,
    this.fontSize = 16,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: hintTextColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorStyles.mainColor, width: borderwidth),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorStyles.mainColor, width: borderwidth + 0.5),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          suffixIcon: GestureDetector(
            child: const Icon(
              Icons.search,
              color: ColorStyles.mainColor,
              size: 30,
            ),
            onTap: () => onTap(),
          ),
        ),
      ),
    );
  }
}
