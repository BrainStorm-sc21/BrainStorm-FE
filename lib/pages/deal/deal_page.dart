import 'package:brainstorm_meokjang/pages/deal/map_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/register_page.dart';
import 'package:brainstorm_meokjang/pages/deal/trading_board_page.dart';
import 'package:brainstorm_meokjang/providers/deal_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

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
  final DealListController _dealListController = Get.put(DealListController());

  final TextEditingController _textEditingController = TextEditingController();

  final List<bool> _checkDeal = [false, false, false];
  final String _selectedValue = '가까운순';
  final List<String> _valueList = ['가까운순', '최신순'];

  @override
  void initState() {
    _dealListController.getServerDealDataWithDio(widget.userId);
    super.initState();
    // sortPosts('최신순');
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void setDeal(int dealType) => setState(() {
        _checkDeal[dealType] = !_checkDeal[dealType];
        if (_checkDeal.contains(true)) {
          _dealListController.changeDeal(_dealListController.entirePosts
              .where((deal) => _checkDeal[deal.dealType] == true)
              .toList());
        } else {
          _dealListController.changeDeal(_dealListController.entirePosts);
        }
      });

  void setSearch(text) => setState(() {
        if (text == '') {
          _dealListController.changeDeal(_dealListController.entirePosts);
        } else {
          _dealListController.changeDeal(_dealListController.entirePosts
              .where((deal) => deal.dealName.contains(text) == true)
              .toList());
        }
      });
  void setdropdown(String selectedValue, String value) =>
      setState(() => selectedValue = value);

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
                      Obx(
                        () => Expanded(
                            child: (_dealListController.changePosts.isEmpty)
                                ? const Center(
                                    child: Text('주변 같이먹장이 없습니다!'),
                                  )
                                : TradingBoard(
                                    posts: _dealListController.changePosts,
                                    userId: widget.userId,
                                  )),
                      ),
                    ],
                  )
                : Stack(children: [
                    Obx(() {
                      if (_dealListController.changePosts.isEmpty == true) {
                        print('아무것도 없음');
                      }
                      return MapPage(
                        posts: _dealListController.changePosts,
                        userId: widget.userId,
                      );
                    }),
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
            onChanged: (value) => _dealListController.sortDeal(value!),
            underline: Container(),
            elevation: 2),
      ),
    );
  }

  SpeedDial _registerDealButton() {
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
                  builder: (context) => RegisterPage(
                    userId: widget.userId,
                    dealType: 2,
                    title: '나눔하기',
                    subTitle: '필요 이상으로 많은 식재료를\n이웃에게 나눔해요',
                  ),
                ),
              );
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
                  builder: (context) => RegisterPage(
                    userId: widget.userId,
                    dealType: 1,
                    title: '교환하기',
                    subTitle: '필요 이상으로 많은 식재료를\n이웃과 교환해요',
                  ),
                ),
              );
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
                  builder: (context) => RegisterPage(
                    userId: widget.userId,
                    dealType: 0,
                    title: '공동구매하기',
                    subTitle: '묶음으로만 파는 식재료를\n이웃과 공동구매해요',
                  ),
                ),
              );
            }),
      ],
    );
  }
}
