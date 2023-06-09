import 'dart:async';

import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/providers/userInfo_controller.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.posts, required this.userId});
  final List<Deal> posts;
  final int userId;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  Completer<NaverMapController> _controller = Completer();
  late LatLng myPosition;

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
      content:
          Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
    customM();
  }

  List<Marker> customM() {
    final List<Marker> markers = [];

    setState(() {
      for (var post in widget.posts) {
        OverlayImage.fromAssetImage(
          assetName: DealType.markerImage[post.dealType],
        ).then((image) {
          markers.add(Marker(
              markerId: post.dealName.toString(),
              icon: image,
              captionText: post.dealName,
              width: 30,
              height: 40,
              position: LatLng(post.latitude, post.longitude),
              onMarkerTab: _onMarkerTap));
        });
      }
    });
    return markers;
  }

  _naverMap() {
    return Expanded(
      child: NaverMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
                _userInfoController.latitude, _userInfoController.longitude),
            zoom: 17),
        zoomGestureEnable: true,
        onMapCreated: onMapCreated,
        mapType: MapType.Basic,
        indoorEnable: true,
        markers: customM(),
        onMapTap: _onMapTap,
        maxZoom: 18,
        minZoom: 13,
      ),
    );
  }

  void _onMarkerTap(Marker? marker, Map<String, int?> iconSize) {
    int pos = widget.posts.indexWhere((m) => m.dealName == marker!.captionText);
    bool isMine = (widget.posts[pos].userId == widget.userId) ? true : false;
    Popups.goToPost(context, widget.userId, widget.posts[pos], isMine);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
