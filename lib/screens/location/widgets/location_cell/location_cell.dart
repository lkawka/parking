import 'package:flutter/material.dart';
import 'package:parking/models/location.dart';

class LocationCell extends StatelessWidget {
  final Location location;

  LocationCell({this.location});

  @override
  Widget build(BuildContext context) {
    var row = Row(
      children: <Widget>[
        Icon(Icons.location_on),
        Container(
          width: 5.0,
        ),
        Expanded(
          child: Text(
            location.title,
            style: TextStyle(fontSize: 17.0),
          ),
        ),
      ],
    );

    var column = Column(
      children: <Widget>[
        row,
        Container(
          height: 5.0,
        ),
      ],
    );

    var container = Container(
      child: column,
    );

    return container;
  }
}
