import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';

class LngLag extends StatefulWidget {
  const LngLag({super.key});

  @override
  State<LngLag> createState() => _LngLagState();
}

class _LngLagState extends State<LngLag> {
  String stAddress = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          GestureDetector(
            onTap: () async {
              List<Location> locations =
                  await locationFromAddress("Gronausestraat 710, Enschede");
              setState(() {
                stAddress = locations.reversed.last.latitude.toString() +
                    '' +
                    locations.last.longitude.toString();
              });
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Center(child: Text('Convert')),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
