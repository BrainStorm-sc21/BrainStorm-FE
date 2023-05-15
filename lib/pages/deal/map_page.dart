import 'dart:async';
import 'dart:ui';

import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.posts});
  final List<Deal> posts;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<NaverMapController> _controller = Completer();

  final List<Marker> _markers = [];

  final Map markerImage = {
    '공구': 'assets/images/groupMarker.png',
    '교환': 'assets/images/exchangeMarker.png',
    '나눔': 'assets/images/shareMarker.png'
  };

  @override
  void initState() {
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

  _onMapTap(LatLng position) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);

    customM(widget.posts);
  }

  void customM(List<Deal> posts) {
    for (var post in posts) {
      OverlayImage.fromAssetImage(
        assetName: markerImage[post.dealType],
        devicePixelRatio: window.devicePixelRatio,
      ).then((image) {
        _markers.add(Marker(
          markerId: DateTime.now().toIso8601String(),
          icon: image,
          captionText: post.dealName,
          width: 30,
          height: 40,
          position: post.location,
          onMarkerTab: _onMarkerTap,
        ));
        setState(() {});
      });
    }
  }

  _naverMap() {
    return Expanded(
        child: NaverMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.566570, 126.978442),
        zoom: 17,
      ),
      zoomGestureEnable: true,
      onMapCreated: onMapCreated,
      mapType: MapType.Basic,
      indoorEnable: true,
      markers: _markers,
      onMapTap: _onMapTap,
      maxZoom: 17,
      minZoom: 15,
    ));
  }

  // void _onMapTap(LatLng latLng) {
  //   OverlayImage.fromAssetImage(
  //     assetName: "assets/images/exchangeMarker.png",
  //     devicePixelRatio: window.devicePixelRatio,
  //   ).then((image) {
  //     _markers.add(Marker(
  //       markerId: DateTime.now().toIso8601String(),
  //       icon: image,
  //       width: 30,
  //       height: 40,
  //       position: latLng,
  //       onMarkerTab: _onMarkerTap,
  //     ));
  //     setState(() {});
  //   });
  // }

  void _onMarkerTap(Marker? marker, Map<String, int?> iconSize) {
    int pos = _markers.indexWhere((m) => m.markerId == marker!.markerId);
    setState(() {
      _markers[pos].captionText = '선택됨';
    });
    setState(() {
      _markers.removeWhere((m) => m.markerId == marker!.markerId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
