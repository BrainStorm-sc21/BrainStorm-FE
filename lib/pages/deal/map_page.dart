import 'dart:async';

import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:brainstorm_meokjang/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();

  final LocationTrackingMode _trackingMode = LocationTrackingMode.NoFollow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
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
              //padding: const EdgeInsets.all(70),
              child: _searchLayout(),
            ),
          ],
        ),
        onMapCreated: onMapCreated,
        mapType: MapType.Basic,
        initLocationTrackingMode: _trackingMode,
        //locationButtonEnable: true,
        indoorEnable: true,
        onCameraIdle: _onCameraIdle,
        onMapTap: _onMapTap,
        onMapLongTap: _onMapLongTap,
        onMapDoubleTap: _onMapDoubleTap,
        onMapTwoFingerTap: _onMapTwoFingerTap,
        maxZoom: 17,
        minZoom: 15,
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
        CustomSearchBar(
          hinttext: '원하는 거래 검색하기',
          onTap: () => setSearch(),
          backgroundColor: Colors.black,
          foregroundColor: Colors.black,
          borderColor: Colors.black,
          textEditingController: _textEditingController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List<Widget>.generate(3, (index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RoundedOutlinedButton(
                  text: _deals[index],
                  fontSize: 15,
                  onPressed: () => setDeal(index),
                  //width: MediaQuery.of(context).size.width / 4.0 - 100,
                  width: 50,
                  backgroundColor:
                      _isDeal[index] ? _colors[index] : Colors.white,
                  foregroundColor: _isDeal[index] ? Colors.white : Colors.black,
                  borderColor: _colors[index],
                ));
          }),
        ),
      ],
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
