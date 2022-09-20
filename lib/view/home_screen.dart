import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.96095886852007, 67.03327654056879),
    zoom: 14,
  );
  List<Marker> _marker = [];
  final List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.96095886852007, 67.03327654056879),
        infoWindow: InfoWindow(title: 'My Location')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(25.027031834675903, 67.14843287510035),
        infoWindow: InfoWindow(title: 'Gulshan')),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error' + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          mapToolbarEnabled: true,
          mapType: MapType.normal,
          compassEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_disabled_outlined),
          onPressed: (() async {
            getUserCurrentLocation().then((value) async {
              print('My curent Location');
              print(
                  value.latitude.toString() + '' + value.longitude.toString());
              _marker.add(
                Marker(
                    markerId: MarkerId('2'),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: InfoWindow(title: 'My Location')),
              );
              CameraPosition cameraPosition = CameraPosition(
                zoom: 14,
                target: LatLng(value.latitude, value.longitude),
              );
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            });
          }),
        ),
      ),
    );
  }
}
