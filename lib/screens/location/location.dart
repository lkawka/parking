import 'package:flutter/material.dart';
import 'package:parking/models/location.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Location _location;

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        appBar: PreferredSize(
            child: TextField(
              decoration: InputDecoration(labelText: "Search for location..."),
            ),
            preferredSize: Size(100.0, 40.0)));

    var safeArea = SafeArea(
//      top: false,
      bottom: false,
      child: scaffold,
    );

    return safeArea;
  }
}
