import 'dart:async';

import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:brainstorm_meokjang/utilities/rule.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.posts, required this.userId});
  final List<Deal> posts;
  final int userId;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<NaverMapController> _controller = Completer();
  LatLng myPosition = const LatLng(37.286828, 127.0577689);

  Future getMyLocation() async {
    Dio dio = Dio();

    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      Response resp = await dio.get("/users/${widget.userId}");

      User user = User.fromJson(resp.data);

      if (resp.data['status'] == 200) {
        print('회원 불러오기 성공!!');
        print(resp.data);
        setState(() {
          myPosition = LatLng(user.latitude, user.longitude);
        });
      } else if (resp.data['status'] == 400) {
        print('회원 불러오기 실패!!');
        throw Exception('Failed to send data [${resp.statusCode}]');
      }
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  @override
  void initState() {
    getMyLocation();
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
    customM();
  }

  List<Marker> customM() {
    final List<Marker> markers = [];

    setState(() {
      for (var post in widget.posts) {
        OverlayImage.fromAssetImage(
          assetName: DealType.markerImage[post.dealType],
          //devicePixelRatio: window.devicePixelRatio,
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
        initialCameraPosition:
            CameraPosition(target: myPosition, zoom: 17),
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
    Popups.goToPost(context, widget.posts[pos]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
