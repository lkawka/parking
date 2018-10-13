import 'package:flutter/material.dart';
import 'package:parking/models/posting.dart';

class RentCell extends StatelessWidget {
  final Posting posting;

  RentCell(this.posting);

  @override
  Widget build(BuildContext context) {
    var row = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            posting.title,
            style: TextStyle(fontSize: 17.0),
          ),
        ),
        Text(
          "${posting.price.toInt()} PLN",
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );

    var cell = Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: row,
    );

    var column = Column(
      children: <Widget>[
        cell,
        Container(
          height: 5.0,
        )
      ],
    );

    return column;
  }
}
