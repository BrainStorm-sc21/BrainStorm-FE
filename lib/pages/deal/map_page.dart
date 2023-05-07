import 'dart:async';

import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();

  final List<String> _deals = ['공동 구매', '교환', '나눔'];
  final List<bool> _isDeal = [false, false, false];
  final List<Color> _colors = [
    const Color.fromARGB(255, 219, 217, 70),
    const Color.fromARGB(255, 140, 202, 99),
    const Color.fromARGB(255, 76, 160, 230)
  ];

  void setDeal(int index) => setState(() => _isDeal[index] = !_isDeal[index]);

  final LocationTrackingMode _trackingMode = LocationTrackingMode.NoFollow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          NaverMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.566570, 126.978442),
              zoom: 17,
            ),
            onMapCreated: onMapCreated,
            mapType: MapType.Basic,
            initLocationTrackingMode: _trackingMode,
            locationButtonEnable: true,
            indoorEnable: true,
            onCameraIdle: _onCameraIdle,
            onMapTap: _onMapTap,
            onMapLongTap: _onMapLongTap,
            onMapDoubleTap: _onMapDoubleTap,
            onMapTwoFingerTap: _onMapTwoFingerTap,
            maxZoom: 17,
            minZoom: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: _searchLayout(),
          ),
          _registerButton(),
        ],
      ),
    );
  }

  _onMapTap(LatLng position) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapLongTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('[onLongTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapDoubleTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('[onDoubleTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapTwoFingerTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('[onTwoFingerTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _searchLayout() {
    return Column(
      children: [
        Container(
            decoration:
                BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(40)),
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
    );
  }

  _registerButton() {
    return Align(
      alignment: Alignment.bottomRight,
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
      ),
    );
  }

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  /// my location button
  // void _onTapLocation() async {
  //   final controller = await _controller.future;
  //   controller.setLocationTrackingMode(LocationTrackingMode.Follow);
  // }

  void _onCameraIdle() {
    print('카메라 움직임 멈춤');
  }
}
