import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:brainstorm_meokjang/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class OthersProfile extends StatelessWidget {
  final String userName;
  final double reliability;
  const OthersProfile({
    super.key,
    required this.userName,
    required this.reliability,
  });

  Widget get reliabilityBox {
    return Column(
      children: [
        Text(
          reliability.toString(),
          style: const TextStyle(
            color: ColorStyles.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: [
            Container(
              alignment: FractionalOffset(
                reliability / 100,
                1 - (reliability / 100),
              ),
              child: FractionallySizedBox(
                child: Column(
                  children: [
                    Text(
                      reliability.toString(),
                      style: const TextStyle(
                        color: ColorStyles.lightYellow,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Image.asset(
                      'assets/images/inverted_triangle1.png',
                    ),
                  ],
                ),
              ),
            ),
            CustomProgressBar(
              paddingHorizontal: 5,
              currentPercent: reliability,
              maxPercent: 100,
              lineHeight: 12,
              firstColor: ColorStyles.lightYellow,
              secondColor: ColorStyles.lightYellow,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorStyles.mainColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(
                'assets/images/myPagebackground.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6,
                            ),
                            child: Text(
                              userName,
                              style: const TextStyle(fontSize: 25),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.error_outline_sharp,
                              color: ColorStyles.iconColor,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    reliabilityBox,
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorStyles.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: ColorStyles.shadowColor,
                              spreadRadius: 5,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  ProfileListItem(
                                    title: "작성한 게시글 보기",
                                    onPressed: () {},
                                  ),
                                  ProfileListItem(
                                    title: "후기 내역 보기",
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
