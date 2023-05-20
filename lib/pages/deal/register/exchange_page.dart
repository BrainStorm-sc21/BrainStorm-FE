import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class ExchangePage extends StatelessWidget {
  const ExchangePage({super.key});

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
                title: '교환하기',
                subTitle: '필요 이상으로 많은 식재료를\n이웃과 교환해요',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    TitleInput(),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: DescriptionInput(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: PhotoBoxInput(),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const BottomButton(),
          ],
        ),
      ),
    );
  }
}
