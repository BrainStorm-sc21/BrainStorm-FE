import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/deal/map_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/exchange_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/group_purchase_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/sharing_page.dart';
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

  void setDeal(int dealType) => setState(() {
        _checkDeal[dealType] = !_checkDeal[dealType];
        if (_checkDeal.contains(true)) {
          posts = dealData.data
              .where((deal) => _checkDeal[deal.dealType] == true)
              .toList();
        } else {
          posts = dealData.data;
        }
      });
  void setSearch() => setState(() {});
  void setdropdown(String selectedValue, String value) =>
      setState(() => selectedValue = value);

  final TextEditingController _textEditingController = TextEditingController();

  List<Deal> posts = List.empty(growable: true);
  late DealData dealData;

  Future getServerDealDataWithDio() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      Response resp = await dio.get("/deal/3/around");

      print("Deal Status: ${resp.statusCode}");
      print("Data:\n${resp.data}");

      DealData dealData = DealData.fromJson(resp.data);

      setState(() {
        for (Deal dealitem in dealData.data) {
          posts.add(dealitem);
        }
      });
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  // void initDeals() {
  //   for (var deal in entirePosts) {
  //     posts.add(Deal(
  //         userId: deal.userId,
  //         dealName: deal.dealName,
  //         dealType: deal.dealType,
  //         distance: deal.distance,
  //         dealContent: deal.dealContent,
  //         latitude: deal.latitude,
  //         longitude: deal.longitude,
  //         dealTime: deal.dealTime,
  //         dealImage1: deal.dealImage1));
  //   }
  // }

  // List<Deal> entirePosts = [
  //   Deal(
  //       userId: 1,
  //       dealId: 1,
  //       dealName: "감자 공동구매 하실 분!",
  //       dealType: "공구",
  //       dealContent: "내용0",
  //       distance: "150M",
  //       latitude: 37.284859,
  //       longitude: 127.044508,
  //       dealTime: "30분전",
  //       dealImage1:
  //           'https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcR1M89lNmXLBltfEc5TQZJSpcqvZ36vvZyZfpP98EFh-i4Q9X8S8woN6El91b1pZ5Sw'),
  //   Deal(
  //       userId: 2,
  //       dealId: 2,
  //       dealName: "양파 나눔해요~",
  //       dealType: "나눔",
  //       distance: "400M",
  //       dealContent: "내용1",
  //       latitude: 37.28419,
  //       longitude: 127.043608,
  //       dealTime: "57분전",
  //       dealImage1:
  //           'https://i.namu.wiki/i/qTfdtopPV7GKQ0YmjVsHxythtmlSQ35OppjcjwJgHJoLVXzx5iCZRFHaq-mXoTR5cl-j2X4SQm1xvyj2hhxBEw.webp'),
  //   Deal(
  //       userId: 3,
  //       dealId: 3,
  //       dealName: "이천 쌀 공구하실 분 구합니다!!",
  //       dealType: "공구",
  //       distance: "1.2M",
  //       dealContent: "내용2",
  //       latitude: 37.283159,
  //       longitude: 127.0446788,
  //       dealTime: "1시간 전",
  //       dealImage1: 'https://www.newspeak.kr/news/photo/202209/435707_284048_3504.jpg'),
  //   Deal(
  //       userId: 4,
  //       dealId: 4,
  //       dealName: "사과랑 바나나 교환해요",
  //       dealType: "교환",
  //       distance: "750M",
  //       dealContent: "내용3",
  //       latitude: 37.284659,
  //       longitude: 127.04460887569,
  //       dealTime: "2시간 전",
  //       dealImage1:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRlxKlz8H0tHG-DpyUhBOOo6wpGw_NnEYPMLDjrfVA3aSPyIdCfmzS_fzOcnj0seChhGo&usqp=CAU'),
  //   Deal(
  //       userId: 5,
  //       dealId: 5,
  //       dealName: "이건 정말 긴 제목을 가지고 있는 게시물의 테스트를 위한 더미값입니다",
  //       dealType: "나눔",
  //       distance: "750M",
  //       dealContent: "내용4",
  //       latitude: 37.283959,
  //       longitude: 127.04467148,
  //       dealTime: "2시간 전",
  //       dealImage1: 'https://i.pinimg.com/originals/b0/df/95/b0df95cfc6f31293d002d4d6daac253c.jpg')
  // ];

  @override
  void initState() {
    super.initState();
    getServerDealDataWithDio();

    //initDeals();
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
              onTap: () => setSearch(),
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
                              onPressed: () => setDeal(index),
                              backgroundColor: _checkDeal[index]
                                  ? DealType.dealTextColors[index]
                                  : ColorStyles.white,
                              foregroundColor: _checkDeal[index]
                                  ? ColorStyles.white
                                  : ColorStyles.black,
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
                            ? const Icon(Icons.map,
                                color: ColorStyles.mainColor)
                            : const Icon(Icons.format_list_bulleted,
                                color: ColorStyles.mainColor)),
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
                border: Border.all(
                    color: ColorStyles.black,
                    style: BorderStyle.solid,
                    width: 0.7)),
            child: DropdownButton(
                value: _selectedValue,
                items: _valueList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style: const TextStyle(
                                  fontSize: 14, color: ColorStyles.textColor)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value!;
                    if (_selectedValue == '거리순') {
                      posts.sort((a, b) => a.distance.compareTo(b.distance));
                    } else if (_selectedValue == '최신순') {
                      //posts.sort((a, b) => a.dealTime.compareTo(b.dealTime));
                    }
                  });
                },
                underline: Container(),
                elevation: 2)));
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
                style: TextStyle(
                    color: ColorStyles.shareTextColor,
                    fontWeight: FontWeight.w600)),
            backgroundColor: ColorStyles.shareColor,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SharingPage()));
            }),
        SpeedDialChild(
            child: const Text('교환',
                style: TextStyle(
                    color: ColorStyles.exchangeTextColor,
                    fontWeight: FontWeight.w600)),
            backgroundColor: ColorStyles.exchangeColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExchangePage()));
            }),
        SpeedDialChild(
            child: const Text('공구',
                style: TextStyle(
                    color: ColorStyles.groupBuyTextColor,
                    fontWeight: FontWeight.w600)),
            backgroundColor: ColorStyles.groupBuyColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GroupPurchasePage()));
            }),
      ],
    );
  }
}
