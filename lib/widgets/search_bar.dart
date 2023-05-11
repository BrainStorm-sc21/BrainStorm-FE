import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hinttext;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final double fontSize;

  final TextEditingController textEditingController;

  const CustomSearchBar({
    super.key,
    this.hinttext = '검색',
    required this.onTap,
    this.width = 50,
    this.height = 35,
    this.borderRadius = 40,
    required this.borderColor,
    this.fontSize = 16,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(40)),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hinttext,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          filled: true,
          fillColor: Colors.transparent,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorStyles.mainColor, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorStyles.mainColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          suffixIcon: GestureDetector(
            child: const Icon(
              Icons.search,
              color: ColorStyles.mainColor,
              size: 25,
            ),
            onTap: () => onTap,
          ),
        ),
      ),
    );
  }
}
