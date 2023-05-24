import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<String> dealInfo = ["거래 내역", "받은 후기", "보낸 후기", "관심 거래"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: ColorStyles.mainColor,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("슬리버바"),
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "내 신뢰도",
                      style: TextStyle(
                          color: ColorStyles.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: const FractionalOffset(43 / 50, 1 - 43 / 50),
                          child: FractionallySizedBox(
                            child: Column(
                              children: [
                                const Text("4.3", style: TextStyle(color: ColorStyles.lightYellow)),
                                const SizedBox(height: 3),
                                Image.asset('assets/images/inverted_triangle1.png'),
                              ],
                            ),
                          ),
                        ),
                        const CustomProgressBar(
                          paddingHorizontal: 5,
                          currentPercent: 43,
                          maxPercent: 50,
                          lineHeight: 12,
                          firstColor: ColorStyles.lightYellow,
                          secondColor: ColorStyles.lightYellow,
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List<Widget>.generate(4, (index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                  width: 85,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: ColorStyles.lightmainColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dealInfo[index],
                                        style: const TextStyle(
                                            color: ColorStyles.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Text(
                                        '10',
                                        style: TextStyle(color: ColorStyles.white, fontSize: 18),
                                      )
                                    ],
                                  )));
                        }))
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text('Item #$index')),
                childCount: 10),
          )
        ],
      ),
    );
  }
}
