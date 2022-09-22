import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleApiPlaces extends StatefulWidget {
  const GoogleApiPlaces({super.key});

  @override
  State<GoogleApiPlaces> createState() => _GoogleApiPlacesState();
}

class _GoogleApiPlacesState extends State<GoogleApiPlaces> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '123456';

  List<dynamic> _placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getseggestion(_controller.text);
  }

  void getseggestion(String input) async {
    String kPLACES_API_KEY = 'AIzaSyAKkzI_ykpKTxykdXC0Zv3OHyr3ZXMJAUU';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var reponse = await http.get(Uri.parse(request));
    var data = reponse.body.toString();
    print(data);
    print(reponse.body.toString());
    if (reponse.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(reponse.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Api Places'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    hintText: 'Search places with name'),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_placesList[index]['description']),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
