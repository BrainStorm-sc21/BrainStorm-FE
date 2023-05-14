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

  final List<String> _deals = ['공동 구매', '교환', '나눔'];
  final List<bool> _isDeal = [false, false, false];
  final List<Color> _colors = [
    ColorStyles.groupBuyColor,
    ColorStyles.exchangColor,
    ColorStyles.shareColor
  ];

  void setDeal(int index) => setState(() => _isDeal[index] = !_isDeal[index]);
  void setSearch() => setState(() {});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: isDealPage
              ? Column(
                  children: [
                    _searchLayout(),
                    const Expanded(child: TradingBoard()),
                  ],
                )
              : Stack(children: [
                  const MapPage(),
                  _searchLayout(),
                ])),
      floatingActionButton: _registerButton(),
    );
  }

  _searchLayout() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            CustomSearchBar(
              hinttext: '원하는 거래 검색하기',
              onTap: () => setSearch(),
              borderColor: ColorStyles.black,
              textEditingController: _textEditingController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List<Widget>.generate(3, (index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        child: RoundedOutlinedButton(
                          text: _deals[index],
                          fontSize: 15,
                          onPressed: () => setDeal(index),
                          width: MediaQuery.of(context).size.width / 4.0 - 100,
                          backgroundColor: _isDeal[index] ? _colors[index] : ColorStyles.white,
                          foregroundColor: _isDeal[index] ? ColorStyles.white : ColorStyles.black,
                          borderColor: _colors[index],
                        ));
                  }),
                ),
                OutlineCircleButton(
                    radius: 35.0,
                    borderSize: 0.5,
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
            )
          ],
        ));
  }

  _registerButton() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      visible: true,
      curve: Curves.bounceIn,
      backgroundColor: ColorStyles.mainColor,
      childPadding: const EdgeInsets.all(1),
      spaceBetweenChildren: 10,
      renderOverlay: false,
      closeManually: false,
      children: [
        SpeedDialChild(
            child: const Text('나눔'),
            backgroundColor: ColorStyles.shareColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
        SpeedDialChild(
            child: const Text('교환'),
            backgroundColor: ColorStyles.exchangColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
        SpeedDialChild(
            child: const Text('공구'),
            backgroundColor: ColorStyles.groupBuyColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
      ],
    );
  }
}
