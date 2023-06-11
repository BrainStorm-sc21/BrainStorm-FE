import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/register_post/register_post_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final int userId;
  final int dealType;
  final String title;
  final String subTitle;

  const RegisterPage({
    super.key,
    required this.userId,
    required this.dealType,
    required this.title,
    required this.subTitle,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Deal deal;

  void registerPost() async {
    if (deal.dealName == '' || deal.dealContent == '') {
      showToast('제목과 상세설명을 입력해주세요');
    } else {
      requestRegisterPost(widget.userId, deal, context);
    }
  }

  @override
  void initState() {
    super.initState();
    initDealData();
  }

  void initDealData() {
    deal = Deal(
      userId: widget.userId,
      dealType: widget.dealType,
      dealName: '',
      dealContent: '',
      dealImage1: null,
      dealImage2: null,
      dealImage3: null,
      dealImage4: null,
      distance: 0.0,
      latitude: 0.0,
      longitude: 0.0,
      createdAt: DateTime.now(),
    );
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
            SafeArea(
              child: TopBar(
                title: widget.title,
                subTitle: widget.subTitle,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
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
