import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<String> _deals = ['공동 구매', '교환', '나눔'];
  final List<bool> _isDeal = [false, false, false];
  final List<Color> _colors = [
    const Color.fromARGB(255, 219, 217, 70),
    const Color.fromARGB(255, 140, 202, 99),
    const Color.fromARGB(255, 76, 160, 230)
  ];

  void setDeal(int index) => setState(() => _isDeal[index] = !_isDeal[index]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, borderRadius: BorderRadius.circular(40)),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "거래 검색하기"),
                )),
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
          ],
        ),
      ),
      floatingActionButton: floatingButtons(context),
    );
  }

  Widget? floatingButtons(BuildContext context) {
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
            backgroundColor: ColorStyles.mainColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
        SpeedDialChild(
            child: const Text('교환'),
            backgroundColor: ColorStyles.mainColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
        SpeedDialChild(
            child: const Text('공구'),
            backgroundColor: ColorStyles.mainColor,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
            }),
      ],
    );
  }
}
