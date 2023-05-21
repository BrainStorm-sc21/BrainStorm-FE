import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/deal/map_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/exchange_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/group_purchase_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/sharing_page.dart';
import 'package:brainstorm_meokjang/pages/start/onboarding_page.dart';
import 'package:brainstorm_meokjang/pages/deal/trading_board_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DealPage extends StatefulWidget {
  const DealPage({Key? key}) : super(key: key);

  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  bool isDealPage = true;

  final List<bool> _checkDeal = [false, false, false];
  final List<String> _valueList = ['거리순', '최신순'];
  String _selectedValue = '거리순';

  // void setDeal(int dealType) => setState(() {
  //       _checkDeal[dealType] = !_checkDeal[dealType];
  //       if (_checkDeal.contains(true)) {
  //         posts = dealData.data.where((deal) => _checkDeal[deal.dealType] == true).toList();
  //       } else {
  //         posts = dealData.data;
  //       }
  //     });

  void setDeal(int dealType) => setState(() {
        _checkDeal[dealType] = !_checkDeal[dealType];
        if (_checkDeal.contains(true)) {
          posts = entirePosts.where((deal) => _checkDeal[deal.dealType] == true).toList();
        } else {
          posts = entirePosts;
        }
      });

  void setSearch(text) => setState(() {
        if (text == Null) {
          posts = entirePosts;
        } else {
          posts = entirePosts
              .where((deal) => deal.dealName.contains(_textEditingController.text))
              .toList();
        }
      });
  void setdropdown(String selectedValue, String value) => setState(() => selectedValue = value);

  final TextEditingController _textEditingController = TextEditingController();

  List<Deal> entirePosts = [
    Deal(
        userId: 1,
        dealId: 0,
        dealName: "감자 공동구매 하실 분!",
        dealType: 0,
        distance: 150,
        dealContent: "~~",
        latitude: 37.284159,
        longitude: 127.044608,
        createdAt: DateTime.parse('2023-05-21T11:58:20.551705'),
        dealImage1:
            'https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcR1M89lNmXLBltfEc5TQZJSpcqvZ36vvZyZfpP98EFh-i4Q9X8S8woN6El91b1pZ5Sw'),
    Deal(
        userId: 2,
        dealId: 1,
        dealName: "양파 나눔해요~",
        dealType: 2,
        distance: 400,
        dealContent: "양파 나눔 내용",
        latitude: 37.2840,
        longitude: 127.044607,
        createdAt: DateTime.parse('2023-05-21 11:22:50.030315'),
        dealImage1:
            'https://i.namu.wiki/i/qTfdtopPV7GKQ0YmjVsHxythtmlSQ35OppjcjwJgHJoLVXzx5iCZRFHaq-mXoTR5cl-j2X4SQm1xvyj2hhxBEw.webp'),
    Deal(
        userId: 3,
        dealId: 2,
        dealName: "이천 쌀 공구하실 분 구합니다!!",
        dealType: 0,
        distance: 1200,
        dealContent: "이천 쌀 공구 내용",
        latitude: 37.284246805225834,
        longitude: 127.04386542721113,
        createdAt: DateTime.parse('2023-05-20T10:01:20.551705'),
        dealImage1: 'https://www.newspeak.kr/news/photo/202209/435707_284048_3504.jpg'),
    Deal(
        userId: 4,
        dealId: 3,
        dealName: "사과랑 바나나 교환해요",
        dealType: 1,
        distance: 750,
        dealContent: "사과 바나나 교환 내용",
        latitude: 37.2839597,
        longitude: 127.044598,
        createdAt: DateTime.parse('2023-05-18T11:58:20.551705'),
        dealImage1:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRlxKlz8H0tHG-DpyUhBOOo6wpGw_NnEYPMLDjrfVA3aSPyIdCfmzS_fzOcnj0seChhGo&usqp=CAU'),
    Deal(
        userId: 5,
        dealId: 4,
        dealName: "이건 정말 긴 제목을 가지고 있는 게시물의 테스트를 위한 더미값입니다",
        dealType: 2,
        distance: 900,
        dealContent:
            "이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.이건 정말 긴 내용을 가지고 있는 게시물의 테스트를 위한 더미값입니다.",
        latitude: 37.2839598,
        longitude: 127.044599,
        createdAt: DateTime.parse('2023-05-19T11:58:20.551705'),
        dealImage1: 'https://i.pinimg.com/originals/b0/df/95/b0df95cfc6f31293d002d4d6daac253c.jpg')
  ];

  List<Deal> posts = List.empty(growable: true);
  late DealData dealData;

  Future getServerDealDataWithDio() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      Response resp = await dio.get("/deal/1/around");

      print("Deal Status: ${resp.statusCode}");
      print("Data:\n${resp.data}");

      // DealData dealData = DealData.fromJson(resp.data);

      // setState(() {
      //   for (Deal dealitem in dealData.data) {
      //     posts.add(dealitem);
      //   }
      // });
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getServerDealDataWithDio();
    initDeals();
  }

  void initDeals() {
    for (var deal in entirePosts) {
      posts.add(Deal(
          userId: deal.userId,
          dealName: deal.dealName,
          dealType: deal.dealType,
          distance: deal.distance,
          dealContent: deal.dealContent,
          latitude: deal.latitude,
          longitude: deal.longitude,
          createdAt: deal.createdAt,
          dealImage1: deal.dealImage1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: isDealPage
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _searchLayout(),
                    _dealDropDown(),
                    Expanded(child: TradingBoard(posts: posts)),
                  ],
                )
              : Stack(children: [
                  MapPage(posts: posts),
                  _searchLayout(),
                ])),
      floatingActionButton: _registerDealButton(),
    );
  }

  _searchLayout() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomSearchBar(
              onTap: () => setSearch(_textEditingController),
              fillColor: ColorStyles.translucent,
              borderColor: ColorStyles.black,
              textEditingController: _textEditingController,
              borderwidth: 2,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: List<Widget>.generate(3, (index) {
                        return Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: RoundedOutlinedButton(
                              height: 30,
                              text: DealType.dealTypeName[index],
                              fontSize: 15,
                              onPressed: () =>
                                  //dealData.data.isEmpty ? print("값 없음") : setDeal(index),
                                  entirePosts.isEmpty ? print("값 없음") : setDeal(index),
                              backgroundColor: _checkDeal[index]
                                  ? DealType.dealTextColors[index]
                                  : ColorStyles.white,
                              foregroundColor:
                                  _checkDeal[index] ? ColorStyles.white : ColorStyles.black,
                              borderColor: DealType.dealTextColors[index],
                              borderwidth: 2,
                            ));
                      }),
                    ),
                    OutlineCircleButton(
                        radius: 35,
                        borderSize: 0.8,
                        borderColor: ColorStyles.grey,
                        onTap: () {
                          setState(() {
                            isDealPage = !isDealPage;
                          });
                        },
                        child: isDealPage
                            ? const Icon(Icons.map, color: ColorStyles.mainColor)
                            : const Icon(Icons.format_list_bulleted, color: ColorStyles.mainColor)),
                  ],
                )),
          ],
        ));
  }

  _dealDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 27,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(color: ColorStyles.black, style: BorderStyle.solid, width: 0.7)),
        child: DropdownButton(
            value: _selectedValue,
            items: _valueList
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e,
                          style: const TextStyle(fontSize: 14, color: ColorStyles.textColor)),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
                if (_selectedValue == '거리순') {
                  posts.sort((a, b) => a.distance.compareTo(b.distance));
                } else if (_selectedValue == '최신순') {
                  posts.sort((b, a) => a.createdAt.compareTo(b.createdAt));
                  posts.reversed;
                }
              });
            },
            underline: Container(),
            elevation: 2),
      ),
    );
  }

  _registerDealButton() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      iconTheme: const IconThemeData(size: 35),
      visible: true,
      curve: Curves.bounceIn,
      backgroundColor: ColorStyles.mainColor,
      childPadding: const EdgeInsets.all(2),
      spaceBetweenChildren: 10,
      renderOverlay: false,
      closeManually: false,
      children: [
        SpeedDialChild(
            child: const Text('나눔',
                style: TextStyle(color: ColorStyles.shareTextColor, fontWeight: FontWeight.w600)),
            backgroundColor: ColorStyles.shareColor,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SharingPage()));
            }),
        SpeedDialChild(
            child: const Text('교환',
                style:
                    TextStyle(color: ColorStyles.exchangeTextColor, fontWeight: FontWeight.w600)),
            backgroundColor: ColorStyles.exchangeColor,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const ExchangePage()));
            }),
        SpeedDialChild(
            child: const Text('공구',
                style:
                    TextStyle(color: ColorStyles.groupBuyTextColor, fontWeight: FontWeight.w600)),
            backgroundColor: ColorStyles.groupBuyColor,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const GroupPurchasePage()));
            }),
        SpeedDialChild(
            child: const Text('회_임시'),
            backgroundColor: ColorStyles.mainColor,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const OnboardingPage()));
            }),
      ],
    );
  }
}
