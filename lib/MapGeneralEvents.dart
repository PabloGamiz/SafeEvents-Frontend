import 'dart:async';

import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'http_models/GeneralEventsModel.dart';
import 'http_requests/http_generalevents.dart';

class MapGeneralEvents extends StatefulWidget {
  @override
  State<MapGeneralEvents> createState() => MapGeneralEventsState();
}

TextEditingController dircontroller = new TextEditingController();
Location location = new Location();

class MapGeneralEventsState extends State<MapGeneralEvents> {
  Completer<GoogleMapController> _controller = Completer();
  var position;
  List<ListEsdevenimentsModel> generalEvents = List();
  Set<Marker> _markers = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: AddressSearchTextField(
          country: "Spain",
          controller: dircontroller,
          hintText: 'Introdueix una direcció',
          decoration: InputDecoration(
            hintText: "Direcció de l\'Esdeveniment",
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(),
            ),
            filled: true,
          ),
          noResultsText: "No hi han resultats",
          onDone: (AddressPoint point) {
            setState(() {
              _goToPosition(point);
            });
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(53.0000, 9.00000),
          zoom: 4,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrentPosition,
        child: Icon(Icons.my_location),
        backgroundColor: Colors.lightBlue,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Future<void> _goToPosition(AddressPoint point) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(point.latitude, point.longitude),
          zoom: 14,
        ),
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
            zoom: 14,
          ),
        ),
      );
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('userPos'),
            position: LatLng(l.latitude, l.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        );
      });
    });
    await Future.delayed(Duration(seconds: 6));
    locationSubscription.cancel();
  }

  @override
  initState() {
    super.initState();
    _checkPermisions();
    http_GeneralEvents().then((eventsFromServer) {
      setMarkers(eventsFromServer);
    });
  }

  void setMarkers(List<ListEsdevenimentsModel> events) {
    setState(() {
      for (var e in events) {
        if (e.location != null) {
          var loc = e.location.split('--');
          if (loc.length > 1) {
            var loc2 = loc[1];
            var lat, lng;
            lat = double.parse(loc2.toString().split(';')[0]);
            lng = double.parse(loc2.toString().split(';')[1]);
            _markers.add(Marker(
              markerId: MarkerId(((e.id).toString())),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(
                title: e.title,
                snippet: e.description,
                onTap: () {
                  runApp(MaterialApp(
                    home: Mostra(idevent: e.id),
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: [
                      const Locale('en', ''),
                      const Locale('es', ''),
                      const Locale('ca', ''),
                    ],
                    localeResolutionCallback: (locale, supportedLocales) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode == locale.languageCode)
                          return supportedLocale;
                      }
                      return supportedLocales.first;
                    },
                  ));
                },
              ),
            ));
          }
        }
      }
    });
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
