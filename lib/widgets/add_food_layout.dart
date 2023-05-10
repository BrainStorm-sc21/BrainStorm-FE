import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

/// 식품 등록 화면 레이아웃
/// 구조: 배경, 제목, 내용(식품정보), 버튼
class AddFoodLayout extends StatelessWidget {
  final String title;
  final VoidCallback onPressedAddButton;
  final Color containerColor;
  final double horizontalPaddingSize;
  final Widget body; // it must be sliver widget

  const AddFoodLayout({
    super.key,
    required this.title,
    required this.onPressedAddButton,
    this.containerColor = ColorStyles.white,
    this.horizontalPaddingSize = 10,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: containerColor,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: false,
                pinned: false,
                expandedHeight: 200,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ColorStyles.mainColor, ColorStyles.cyan],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorStyles.white,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ColorStyles.mainColor, ColorStyles.cyan],
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPaddingSize),
                sliver: body,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: horizontalPaddingSize),
                    child: SizedBox(
                      height: 78, // button 35 + sizedbox 8 + button 35
                      child: Column(
                        children: [
                          // '등록하기' 버튼
                          RoundedOutlinedButton(
                            text: '등록하기',
                            width: double.infinity,
                            onPressed: onPressedAddButton,
                            foregroundColor: ColorStyles.white,
                            backgroundColor: ColorStyles.mainColor,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                          const SizedBox(height: 8), //여백
                          // '취소하기' 버튼
                          RoundedOutlinedButton(
                            text: '취소하기',
                            width: double.infinity,
                            onPressed: () => Navigator.of(context).pop(),
                            foregroundColor: ColorStyles.mainColor,
                            backgroundColor: ColorStyles.white,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
