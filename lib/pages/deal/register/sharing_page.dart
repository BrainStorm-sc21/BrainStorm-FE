import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class SharingPage extends StatefulWidget {
  const SharingPage({super.key});

  @override
  State<SharingPage> createState() => _SharingPageState();
}

class _SharingPageState extends State<SharingPage> {
  late Deal deal;

  void registerPost() async {
    requestRegisterPost(deal);
  }

  @override
  void initState() {
    super.initState();
    deal = Deal(
        userId: 1,
        dealType: 2,
        dealName: '',
        dealContent: '',
        distance: 0,
        latitude: 0.0,
        longitude: 0.0,
        createdAt: DateTime.now());
  }

  void setTitle(String value) => setState(() => deal.dealName = value);
  void setContent(String value) => setState(() => deal.dealContent = value);
  void setImages(
          String? image1, String? image2, String? image3, String? image4) =>
      setState(() {
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
                title: '나눔하기',
                subTitle: '필요 이상으로 많은 식재료를\n이웃에게 나눔해요',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TitleInput(setTitle: setTitle),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20),
                    //   child: ExpirationDateInput(),
                    // ),
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
