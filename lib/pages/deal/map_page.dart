import 'dart:async';
import 'dart:ui';

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

  final List<Marker> _markers = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OverlayImage.fromAssetImage(
        assetName: 'icon/marker.png',
        devicePixelRatio: window.devicePixelRatio,
      ).then((image) {
        setState(() {
          _markers.add(Marker(
              markerId: 'id',
              position: const LatLng(37.566570, 126.978442),
              captionText: "커스텀 아이콘",
              captionColor: Colors.indigo,
              captionTextSize: 20.0,
              alpha: 0.8,
              captionOffset: 30,
              //icon: image,
              anchor: AnchorPoint(0.5, 1),
              width: 45,
              height: 45,
              infoWindow: '인포 윈도우',
              onMarkerTab: _onMarkerTap));
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _naverMap(),
          ],
        ),
      ),
    );
  }

  // _onMapTap(LatLng position) async {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
  //     duration: const Duration(milliseconds: 500),
  //     backgroundColor: Colors.black,
  //   ));
  // }

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  _naverMap() {
    return Expanded(
        child: NaverMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.566570, 126.978442),
        zoom: 17,
      ),
      onMapCreated: onMapCreated,
      mapType: MapType.Basic,
      indoorEnable: true,
      markers: _markers,
      onMapTap: _onMapTap,
      maxZoom: 17,
      minZoom: 15,
    ));
  }

  // ================== method ==========================

  void _onMapTap(LatLng latLng) {
    OverlayImage.fromAssetImage(
      assetName: 'assets/images/임시공구마커.png',
      devicePixelRatio: window.devicePixelRatio,
    ).then((image) {
      _markers.add(Marker(
        markerId: DateTime.now().toIso8601String(),
        //icon: image,
        position: latLng,
        onMarkerTab: _onMarkerTap,
      ));
      setState(() {});
    });
  }

  void _onMarkerTap(Marker? marker, Map<String, int?> iconSize) {
    int pos = _markers.indexWhere((m) => m.markerId == marker!.markerId);
    setState(() {
      _markers[pos].captionText = '선택됨';
    });
    setState(() {
      _markers.removeWhere((m) => m.markerId == marker!.markerId);
    });
  }
}
