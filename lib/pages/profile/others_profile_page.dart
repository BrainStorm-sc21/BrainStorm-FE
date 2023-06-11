import 'package:brainstorm_meokjang/providers/userInfo_controller.dart';
import 'package:brainstorm_meokjang/utilities/Popups.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OthersProfile extends StatelessWidget {
  final int ownerId;
  final String userName;
  final double reliability;
  OthersProfile({
    super.key,
    required this.ownerId,
    required this.userName,
    required this.reliability,
  });

  final UserInfoController _userInfoController = Get.put(UserInfoController());

  Widget get reliabilityBox {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '신뢰도',
            style: TextStyle(
              color: ColorStyles.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
    _userInfoController.getUserIdFromSharedData();
    int myId = _userInfoController.userId;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              color: ColorStyles.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: ColorStyles.snow,
                            ),
                            child: const Icon(
                              Icons.help_rounded,
                              color: ColorStyles.lightgrey,
                              size: 16,
                            ),
                          ),
                          onTap: () {
                            Popups.showReportDialog(
                              context,
                              reporterId: myId,
                              reportedUserId: ownerId,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
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
