import 'package:flutter/material.dart';
import 'package:parking/models/posting.dart';

class RentCell extends StatelessWidget {
  final Posting posting;

  RentCell(this.posting);

  @override
  Widget build(BuildContext context) {
    var row1 = Row(
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

    var row2 = Row(
      children: <Widget>[
        Icon(Icons.location_on),
        Container(width: 5.0,),
        Expanded(
          child: Text(posting.location.title, overflow: TextOverflow.ellipsis),
        )
      ],
    );

    var rows = Column(
      children: <Widget>[
        row1,
        Container(height: 5.0),
        row2,
      ],
    );

    Image image = Image.asset("assets/car.png", scale: 1.8,);
    switch (posting.type) {
      case "BIG":
        image = Image.asset("assets/truck.png", scale: 1.8,);
        break;
      case "MEDIUM":
        image = Image.asset("assets/trailer.png", scale: 1.8,);
        break;
    }

    var superRow = Row(
      children: <Widget>[
        image,
        Container(width: 10.0,),
        Expanded(
          child: rows,
        )
      ],
    );

    var cell = Container(
      padding: EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: superRow,
    );

    var material = Material(
      child: cell,
    );

    var column = Column(
      children: <Widget>[
        material,
        Container(height: 10.0,)
      ],
    );

    return column;
  }
}
