import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/deal/map_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/exchange_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/group_purchase_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/sharing_page.dart';
import 'package:brainstorm_meokjang/pages/deal/trading_board_page.dart';
import 'package:brainstorm_meokjang/pages/profile/othersProfile.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DealPage extends StatefulWidget {
  final int userId;
  const DealPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  bool isDealPage = true;

  final TextEditingController _textEditingController = TextEditingController();

  List<Deal> posts = List.empty(growable: true);
  List<Deal> entirePosts = List.empty(growable: true);

  final List<bool> _checkDeal = [false, false, false];
  String _selectedValue = '거리순';
  final List<String> _valueList = ['가까운순', '최신순'];

  @override
  void initState() {
    super.initState();
    getServerDealDataWithDio();
    // sortPosts('최신순');
  }

  void setDeal(int dealType) => setState(() {
        _checkDeal[dealType] = !_checkDeal[dealType];
        if (_checkDeal.contains(true)) {
          posts = entirePosts
              .where((deal) => _checkDeal[deal.dealType] == true)
              .toList();
        } else {
          posts = entirePosts;
        }
      });

  void setSearch(text) => setState(() {
        if (text == '') {
          posts = entirePosts;
        } else {
          posts = entirePosts
              .where(
                  (deal) => deal.dealName.contains(_textEditingController.text))
              .toList();
        }
      });
  void setdropdown(String selectedValue, String value) =>
      setState(() => selectedValue = value);

  Future getServerDealDataWithDio() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      Response resp = await dio.get("/deal/${widget.userId}/around");

      print("Deal Status: ${resp.statusCode}");
      print("Deal Data: ${resp.data}");

      DealData dealData = DealData.fromJson(resp.data);

      setState(() {
        for (Deal dealitem in dealData.data) {
          posts.add(dealitem);
        }
        entirePosts = dealData.data;
      });
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: isDealPage
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _searchLayout(),
                      _dealDropDown(),
                      Expanded(
                          child: (posts.isEmpty)
                              ? const Center(
                                  child: Text('주변 같이먹장이 없습니다!'),
                                )
                              : TradingBoard(
                                  posts: posts,
                                  userId: widget.userId,
                                )),
                    ],
                  )
                : Stack(children: [
                    MapPage(
                      posts: posts,
                      userId: widget.userId,
                    ),
                    _searchLayout(),
                  ])),
        floatingActionButton: _registerDealButton(),
      ),
    );
  }

  _searchLayout() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomSearchBar(
              onTap: () => setSearch(_textEditingController.text),
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
                                  setDeal(index),
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
            onChanged: (value) => sortPosts(value!),
            underline: Container(),
            elevation: 2),
      ),
    );
  }

  void sortPosts(String value) {
    setState(() {
      _selectedValue = value;
      if (_selectedValue == '거리순') {
      if (_selectedValue == '가까운순') {
        posts.sort((a, b) => a.distance!.compareTo(b.distance!));
      } else if (_selectedValue == '최신순') {
        posts.sort((b, a) => a.createdAt.compareTo(b.createdAt));
      }
    });
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SharingPage(userId: widget.userId)));
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
                      builder: (context) =>
                          ExchangePage(userId: widget.userId)));
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
                      builder: (context) =>
                          GroupPurchasePage(userId: widget.userId)));
            }),
        SpeedDialChild(
            child: const Text('상대 UI',
                style:
                    TextStyle(color: ColorStyles.groupBuyTextColor, fontWeight: FontWeight.w600)),
            backgroundColor: ColorStyles.cream,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const OtherProfile()));
            }),
      ],
    );
  }
}
