import 'package:brainstorm_meokjang/pages/deal/map_page.dart';
import 'package:brainstorm_meokjang/pages/deal/register/post_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/outline_circle_button.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:brainstorm_meokjang/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DealPage extends StatefulWidget {
  const DealPage({Key? key}) : super(key: key);

  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  bool checkpage = true;

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
      //extendBodyBehindAppBar: checkpage ? false : true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: checkpage
              ? AppBar(
                  title: const Text(
                    "같이 먹장",
                    style: TextStyle(
                      color: ColorStyles.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  backgroundColor: ColorStyles.white,
                  elevation: 0,
                )
              : AppBar()), //const EmptyAppBar()),
      body: Stack(
        children: <Widget>[
          checkpage ? const PostPage() : const MapPage(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: _searchLayout(),
          ),
        ],
      ),
      floatingActionButton: _registerButton(),
    );
  }

  _searchLayout() {
    return Column(
      children: [
        CustomSearchBar(
          hinttext: '원하는 거래 검색하기',
          onTap: () => setSearch(),
          borderColor: Colors.black,
          textEditingController: _textEditingController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List<Widget>.generate(3, (index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: RoundedOutlinedButton(
                      text: _deals[index],
                      fontSize: 15,
                      onPressed: () => setDeal(index),
                      width: MediaQuery.of(context).size.width / 4.0 - 100,
                      backgroundColor: _isDeal[index] ? _colors[index] : Colors.white,
                      foregroundColor: _isDeal[index] ? Colors.white : Colors.black,
                      borderColor: _colors[index],
                    ));
              }),
            ),
            OutlineCircleButton(
                radius: 40.0,
                borderSize: 0.5,
                borderColor: Colors.grey,
                onTap: () {
                  setState(() {
                    checkpage = !checkpage;
                  });
                },
                child: checkpage
                    ? const Icon(Icons.map, color: ColorStyles.mainColor)
                    : const Icon(Icons.format_list_bulleted, color: ColorStyles.mainColor)),
          ],
        )
      ],
    );
  }

  _registerButton() {
    return Align(
      alignment: const Alignment(0.96, 0.96),
      child: SpeedDial(
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
      ),
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => const Size(0.0, 70.0);
}
