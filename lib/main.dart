import 'package:flutter/material.dart';
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
      home: LngLag(),
    );
  }
}
