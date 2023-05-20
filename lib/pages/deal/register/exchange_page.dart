import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  late Deal deal;

  void registerPost() async {
    print("이거 버튼 클릭 되나요??");
    requestRegisterPost(deal);
  }

  @override
  void initState() {
    super.initState();
    deal = Deal(
        userId: 1,
        dealType: 1,
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
                title: '교환하기',
                subTitle: '필요 이상으로 많은 식재료를\n이웃과 교환해요',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleInput(setTitle: setTitle),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DescriptionInput(setContent: setContent),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: PhotoBoxInput(setImages: setImages),
                    ),
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
