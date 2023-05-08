import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class GroupPurchasePage extends StatelessWidget {
  const GroupPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("공동구매 게시글"),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitleInput(),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: NumOfPeopleInput(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: DescriptionInput(),
              ),
              Spacer(),
              BottomButton(),
            ],
          ),
        ),
      ),
    );
  }
}
