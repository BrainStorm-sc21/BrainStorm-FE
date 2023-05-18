import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/deal_detail/deal_detail_widgets.dart';
import 'package:brainstorm_meokjang/widgets/go_to_post/go_to_post_widgets.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class DealDetailPage extends StatefulWidget {
  final String description;

  const DealDetailPage({
    super.key,
    this.description =
        '국산 햇감자 공동구매하실분 찾습니다!!\n아는 분께서 감자농사 하시는데 박스 단위로 판매하시고 있습니다.\n한 박스 사서 나누실 분 모여주세요😆',
  });

  @override
  State<DealDetailPage> createState() => _DealDetailPageState();
}

class _DealDetailPageState extends State<DealDetailPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.3,
                decoration: const BoxDecoration(
                  color: ColorStyles.black,
                  image: DecorationImage(
                      image: AssetImage('assets/images/감자.png'),
                      fit: BoxFit.fitWidth),
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   top: 20,
        //   left: 20,
        //   child: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: ColorStyles.mainColor,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            width: width,
            height: height * 0.72,
            child: Column(
              children: [
                const TopPostUnit(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 10),
                  child: Container(
                    color: Colors.grey[350],
                    height: 0.5,
                    width: double.infinity,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: firstPostUnit(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(widget.description),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  child: RoundedOutlinedButton(
                    onPressed: () {},
                    text: '채팅하기',
                    width: double.infinity,
                    height: 40,
                    backgroundColor: ColorStyles.mainColor,
                    foregroundColor: ColorStyles.white,
                    borderColor: ColorStyles.mainColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
