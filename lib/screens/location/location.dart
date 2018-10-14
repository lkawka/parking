import 'package:flutter/material.dart';
import 'package:parking/models/location.dart';
import 'package:parking/screens/location/widgets/location_cell/index.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var _locations = <Location>[
    Location(title: "Batorego 29, Warszawa", lat: 52.210777, lng: 21.011922),
    Location(title: "Startberry, Grochowska 306/308, Warszawa",
        lat: 52.210777,
        lng: 21.011922)
  ];

  List<Location> _filteredLocations;


  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];
    if (_filteredLocations == null) {
      _locations.forEach((location) =>
          cells.add(GestureDetector(
              onTap: () {
                Navigator.pop(context, location);
              },
              child: LocationCell(location: location,)),
          ),);
    } else {
      _filteredLocations.forEach((location) =>
          cells.add(GestureDetector(
              onTap: () {
                Navigator.pop(context, location);
              },
              child: LocationCell(location: location,)),
          ),);
    }

    var listView = ListView(
      children: cells,
    );

    var container = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: listView,
    );

    var textField = TextField(
      decoration: InputDecoration(
          hintText: "Search for location...",
          hintStyle: TextStyle(color: Colors.white70),
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none
      ),
      onChanged: (val) {
        print("val: $val");
        if (val == null || val.length == 0) {
          if (_filteredLocations != null) {
            setState(() {
              _filteredLocations = null;
            });
          }
        } else {
          var filtered = _locations.where((location) =>
              location.title.toLowerCase().contains(val.toLowerCase()));
          if (filtered != _filteredLocations) {
            setState(() {
              _filteredLocations = filtered;
            });
          }
        }
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
