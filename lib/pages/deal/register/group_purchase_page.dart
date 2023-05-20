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
  }

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
                  children: const [
                    TitleInput(),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20),
                    //   child: NumOfPeopleInput(),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: DescriptionInput(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: PhotoBoxInput(),
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
