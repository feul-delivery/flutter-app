import 'dart:async';

import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:map/map.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

StreamSubscription _locationSubscription;
Location _locationTracker = Location();
double _distance = 0;

class _MapsState extends State<Maps> {
  Future<double> _getDistance(LocationData locationData) async {
    return Geolocator.distanceBetween(
      34.0259925,
      -6.7951883,
      locationData.latitude,
      locationData.longitude,
    );
  }

  final controller = MapController(
    location: LatLng(35.68, 51.41),
  );

  void _getCurrentLocation() async {
    var _location;
    try {
      _location = await _locationTracker.getLocation();

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        _location = newLocalData;
      });
      controller.center = LatLng(_location.latitude, _location.longitude);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }

    setState(() async {
      _distance = await _getDistance(_location);
    });
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
  }

  Offset _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    controller.tileSize = 256 / devicePixelRatio;

    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Distance is ${(_distance / 1000).toStringAsFixed(0)} Km',
            style: pageTitleX,
          )),
      body: GestureDetector(
        onDoubleTap: _onDoubleTap,
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: (details) {
          print(
              "Location: ${controller.center.latitude}, ${controller.center.longitude}");
        },
        child: Stack(
          children: [
            Map(
              controller: controller,
              builder: (context, x, y, z) {
                final url =
                    'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                return CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                );
              },
            ),
            Center(
              child: Icon(AntDesign.car, color: Colors.black),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _getCurrentLocation,
        tooltip: 'My Location',
        child: Icon(
          OMIcons.myLocation,
          color: Colors.black,
        ),
      ),
    );
  }
}
