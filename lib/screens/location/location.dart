import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/location.dart';
import 'package:parking/screens/location/widgets/location_cell/index.dart';


class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  final dio = new Dio(); // for http requests

  List<dynamic> _preds = [];

  _searchForPlaces(term) async {
    final response = await dio.get(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json", data: {
      "input": term,
      "inputtype": "textquery",
      "key": "AIzaSyBi_rXSpXeG1RTBl2NXvByFarErfddx5v0",
      "radius": 20,
      "location": [52.228601, 21.011511],
    });

    Map<String, dynamic> data = response.data;
    List<dynamic> preds = data["predictions"];

    if (preds != _preds) {
      setState(() {
        _preds = preds;
      });
    }
  }

  Future<Location> _getDetails(pred) async {
    print("pred: $pred");
    final response = await dio.get(
        "https://maps.googleapis.com/maps/api/place/details/json", data: {
      "key": "AIzaSyBi_rXSpXeG1RTBl2NXvByFarErfddx5v0",
      "placeid": pred["place_id"],
    });

    var data = response.data;
    print("detail: $data");
    var location = Location(
        title: pred["description"],
        lat: data["result"]["geometry"]["location"]["lat"],
        lng: data["result"]["geometry"]["location"]["lng"]
    );

    return location;
  }

  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];

    _preds.forEach((pred) =>
        cells.add(GestureDetector(
          onTap: () async {
            Location location = await _getDetails(pred);
            Navigator.pop(context, location);
          },
          child: LocationCell(title: pred["description"]),
        )));

    cells.insert(0, Container(height: 15.0));

    var listView = ListView(
      children: cells,
    );

    var container = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: listView,
    );

    var textField = TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "Search for location...",
          hintStyle: TextStyle(color: Colors.white70),
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none
      ),
      onChanged: (val) {
        print("changed: $val");
        _searchForPlaces(val);
      },
    );

    var scaffold = Scaffold(
      appBar: AppBar(
        title: textField,
      ),
      body: container,
      resizeToAvoidBottomPadding: false,
    );

    return scaffold;
  }
}
