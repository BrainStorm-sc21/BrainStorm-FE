import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class GroupPurchasePage extends StatefulWidget {
  const GroupPurchasePage({super.key});

  @override
  State<GroupPurchasePage> createState() => _GroupPurchasePageState();
}

class _GroupPurchasePageState extends State<GroupPurchasePage> {
  late Deal deal;

  void registerPost() {
    print('공동구매 게시글 등록!');
    requestRegisterPost(deal);
  }

  @override
  void initState() {
    super.initState();
    deal = Deal(
        userId: 1,
        dealType: 0,
        dealName: '',
        dealContent: '',
        distance: 0,
        latitude: 0.0,
        longitude: 0.0,
        createdAt: DateTime.now());
  }

  void setTitle(String value) => setState(() => deal.dealName = value);
  void setContent(String value) => setState(() => deal.dealContent = value);
  void setImages(String value) => setState(() => deal.dealImage1 = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const SafeArea(
              child: TopBar(
                title: '공동구매하기',
                subTitle: '묶음으로만 파는 식재료를\n이웃과 공동구매해요',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleInput(setTitle: setTitle),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20),
                    //   child: NumOfPeopleInput(),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DescriptionInput(setContent: setContent),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: PhotoBoxInput(setImages: setImages),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            BottomButton(registerPost: registerPost),
          ],
        ),
      ),
    );
  }
}
