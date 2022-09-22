import 'package:flutter/material.dart';
import 'package:googleapi/view/current_location/current_location.dart';
import 'package:googleapi/view/google_api_places.dart';
import 'package:googleapi/view/home_screen.dart';
import 'package:googleapi/view/lan_lng.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleApiPlaces(),
    );
  }
}
