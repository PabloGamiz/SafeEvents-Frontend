import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapGeneralEvents extends StatefulWidget {
  @override
  State<MapGeneralEvents> createState() => MapGeneralEventsState();
}

class MapGeneralEventsState extends State<MapGeneralEvents> {
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  var position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(40.416775, -3.703790),
          zoom: 5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrentPosition,
        child: Icon(Icons.my_location),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }

  Future<void> _goToCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    StreamSubscription<LocationData> locationSubscription =
        position.onLocationChanged.listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude, l.longitude),
            zoom: 9,
          ),
        ),
      );
    });
    await Future.delayed(Duration(seconds: 6));
    locationSubscription.cancel();
  }

  @override
  initState() {
    super.initState();
    _checkPermisions();
  }

  Future<void> _checkPermisions() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    position = Location();
  }
}

/*
GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              position.latitude ?? 41.390205, position.longitude ?? 2.154007),
          zoom: 9,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ), */
