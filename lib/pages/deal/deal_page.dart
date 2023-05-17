import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/models/location.dart';
import 'package:brainstorm_meokjang/pages/deal/map_page.dart';
import 'package:brainstorm_meokjang/pages/deal/trading_board_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DealPage extends StatefulWidget {
  const DealPage({Key? key}) : super(key: key);

  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  bool isDealPage = true;

  final List<String> _deals = ['공구', '교환', '나눔'];
  final Map _checkDeal = {'공구': false, '교환': false, '나눔': false};
  final List<Color> _colors = [
    ColorStyles.groupBuyColor,
    ColorStyles.exchangColor,
    ColorStyles.shareColor
  ];

  final List<String> _valueList = ['거리순', '최신순'];
  String _selectedValue = '거리순';

  void setDeal(String dealTypeName) => setState(() {
        _checkDeal[dealTypeName] = !_checkDeal[dealTypeName];
        if (_checkDeal.containsValue(true)) {
          posts = entirePosts.where((deal) => _checkDeal[deal.dealType] == true).toList();
        } else {
          posts = entirePosts;
        }
      });
  void setSearch() => setState(() {});
  void setdropdown(String selectedValue, String value) => setState(() => selectedValue = value);

  final TextEditingController _textEditingController = TextEditingController();

  late Deal deal;
  List<Deal> entirePosts = [
    Deal(
        dealName: "감자 공동구매 하실 분!",
        dealType: "공구",
        distance: "150M",
        location: const LocationClass(latitude: 37.566570, longitude: 126.978442),
        dealTime: "30분전",
        dealImage:
            'https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcR1M89lNmXLBltfEc5TQZJSpcqvZ36vvZyZfpP98EFh-i4Q9X8S8woN6El91b1pZ5Sw'),
    Deal(
        dealName: "양파 나눔해요~",
        dealType: "나눔",
        distance: "400M",
        location: const LocationClass(latitude: 37.56643167934505, longitude: 126.97937927193084),
        dealTime: "57분전",
        dealImage:
            'https://i.namu.wiki/i/qTfdtopPV7GKQ0YmjVsHxythtmlSQ35OppjcjwJgHJoLVXzx5iCZRFHaq-mXoTR5cl-j2X4SQm1xvyj2hhxBEw.webp'),
    Deal(
        dealName: "이천 쌀 공구하실 분 구합니다!!",
        dealType: "공구",
        distance: "1.2M",
        location: const LocationClass(latitude: 37.56555925792482, longitude: 126.97766593224515),
        dealTime: "1시간 전",
        dealImage: 'https://www.newspeak.kr/news/photo/202209/435707_284048_3504.jpg'),
    Deal(
        dealName: "사과랑 바나나 교환해요",
        dealType: "교환",
        distance: "750M",
        location: const LocationClass(latitude: 37.566703547317187, longitude: 126.97782114579604),
        dealTime: "2시간 전",
        dealImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRlxKlz8H0tHG-DpyUhBOOo6wpGw_NnEYPMLDjrfVA3aSPyIdCfmzS_fzOcnj0seChhGo&usqp=CAU'),
    Deal(
        dealName: "이건 정말 긴 제목을 가지고 있는 게시물의 테스트를 위한 더미값입니다",
        dealType: "나눔",
        distance: "750M",
        location: const LocationClass(latitude: 37.566753547317187, longitude: 126.97772114579604),
        dealTime: "2시간 전",
        dealImage: 'https://i.pinimg.com/originals/b0/df/95/b0df95cfc6f31293d002d4d6daac253c.jpg')
  ];

  List<Deal> posts = List.empty(growable: true);

  void initDeals() {
    for (var deal in entirePosts) {
      posts.add(Deal(
          dealName: deal.dealName,
          dealType: deal.dealType,
          distance: deal.distance,
          location: deal.location,
          dealTime: deal.dealTime,
          dealImage: deal.dealImage));
    }
  }

  @override
  void initState() {
    super.initState();

    initDeals();
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
      floatingActionButton: _dealSortButton(),
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
                              text: _deals[index],
                              fontSize: 15,
                              onPressed: () => setDeal(_deals[index]),
                              backgroundColor:
                                  _checkDeal[_deals[index]] ? _colors[index] : ColorStyles.white,
                              foregroundColor:
                                  _checkDeal[_deals[index]] ? ColorStyles.white : ColorStyles.black,
                              borderColor: _colors[index],
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
                  });
                },
                underline: Container(),
                elevation: 2)));
  }

  _dealSortButton() {
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
            child: const Text('나눔', style: TextStyle(color: ColorStyles.white)),
            backgroundColor: ColorStyles.shareColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
        SpeedDialChild(
            child: const Text('교환', style: TextStyle(color: ColorStyles.white)),
            backgroundColor: ColorStyles.exchangColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
        SpeedDialChild(
            child: const Text('공구', style: TextStyle(color: ColorStyles.white)),
            backgroundColor: ColorStyles.groupBuyColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
      ],
    );
  }
}
