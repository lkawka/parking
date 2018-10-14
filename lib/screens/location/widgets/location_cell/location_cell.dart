import 'package:flutter/material.dart';

class LocationCell extends StatelessWidget {
  final String title;

  LocationCell({this.title});

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
            title,
            style: TextStyle(fontSize: 17.0),
          ),
        ),
      ],
    );

    var column = Column(
      children: <Widget>[
        row,
        Container(
          height: 20.0,
        ),
      ],
    );

    var container = Container(
      child: column,
    );

    return container;
  }
}
