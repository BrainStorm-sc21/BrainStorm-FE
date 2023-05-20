import 'dart:async';
import 'dart:ui';

import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _naverMap(),
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

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  List<Marker> customM() {
    final List<Marker> markers = [];

    for (var post in widget.posts) {
      OverlayImage.fromAssetImage(
        assetName: DealType.markerImage[post.dealType],
        devicePixelRatio: window.devicePixelRatio,
      ).then((image) {
        markers.add(Marker(
            markerId: post.dealId.toString(),
            icon: image,
            captionText: post.dealName,
            width: 30,
            height: 40,
            position: LatLng(post.latitude, post.longitude),
            onMarkerTab: _onMarkerTap));
      });
    }
    return markers;
  }

  _naverMap() {
    return Expanded(
      child: NaverMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(37.284159, 127.044608), zoom: 17),
        zoomGestureEnable: true,
        onMapCreated: onMapCreated,
        mapType: MapType.Basic,
        indoorEnable: true,
        markers: customM(),
        onMapTap: _onMapTap,
        maxZoom: 17,
        minZoom: 15,
      ),
    );
  }

  void _onMarkerTap(Marker? marker, Map<String, int?> iconSize) {
    // int pos = _markers.indexWhere((m) => m.markerId == marker!.markerId);
    // setState(() {
    //   _markers[pos].captionText = '선택됨';
    // });
    // setState(() {
    //   _markers.removeWhere((m) => m.markerId == marker!.markerId);
    // });
    Popups.goToPost(context, '나눔');
    // int pos = _markers.indexWhere((m) => m.markerId == marker!.markerId);

    // for (var post in widget.posts) {
    //   if (post.dealName == _markers[pos].captionText) {
    //     Popups.goToPost(context, post);
    //     break;
    //   }
    // }

    // setState(() {
    //   _markers[pos].captionText = '선택됨';
    // });
    // setState(() {
    //   _markers.removeWhere((m) => m.markerId == marker!.markerId);
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
