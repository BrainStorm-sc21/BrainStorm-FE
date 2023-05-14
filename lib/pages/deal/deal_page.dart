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
  final List<bool> _isDeal = [false, false, false];
  final List<Color> _colors = [
    ColorStyles.groupBuyColor,
    ColorStyles.exchangColor,
    ColorStyles.shareColor
  ];

  final List<String> _valueList = ['거리순', '최신순'];
  String _selectedValue = '거리순';

  void setDeal(int index) => setState(() => _isDeal[index] = !_isDeal[index]);
  void setSearch() => setState(() {});
  void setdropdown(String selectedValue, String value) => setState(() => selectedValue = value);

  final TextEditingController _textEditingController = TextEditingController();

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
                              onPressed: () => setDeal(index),
                              backgroundColor: _isDeal[index] ? _colors[index] : ColorStyles.white,
                              foregroundColor:
                                  _isDeal[index] ? ColorStyles.white : ColorStyles.black,
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
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 14, color: ColorStyles.textColor),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value!;
                  });
                },
                //icon: Icon(Icon.),
                underline: Container(),
                elevation: 2)));
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
