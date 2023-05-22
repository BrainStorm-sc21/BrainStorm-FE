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
    requestRegisterPost(deal, context);
  }

  @override
  void initState() {
    super.initState();
    deal = Deal(
        userId: 3,
        dealType: 1,
        dealName: '',
        dealContent: '',
        dealImage1: null,
        dealImage2: null,
        dealImage3: null,
        dealImage4: null,
        distance: 0,
        latitude: 0.0,
        longitude: 0.0,
        createdAt: DateTime.now());
  }

  void setTitle(String value) => setState(() => deal.dealName = value);
  void setContent(String value) => setState(() => deal.dealContent = value);
  void setImages(String? image1, String? image2, String? image3, String? image4) => setState(() {
        deal.dealImage1 = image1;
        deal.dealImage2 = image2;
        deal.dealImage3 = image3;
        deal.dealImage4 = image4;
      });

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
                      child: PhotoBoxInput(
                        setImages: setImages,
                      ),
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
