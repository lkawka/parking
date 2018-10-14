import 'package:flutter/material.dart';
import 'package:parking/models/posting.dart';

class MyMarker extends StatelessWidget {

  final isHighlighted;
  final Posting posting;
  final onTap;

  MyMarker({Key key, this.posting, this.isHighlighted = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset("assets/car.png");
    switch (posting.type) {
      case "BIG":
        image = Image.asset("assets/truck.png");
        break;
      case "MEDIUM":
        image = Image.asset("assets/trailer.png");
        break;
    }

    var marker = Container(
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.white : Colors.white70 ,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//        border: isHighlighted ? Border.all(color: Colors.black12) : null,
      ),
      child: Row(
        children: <Widget>[
          image,
          Container(width: 5.0,),
          Expanded(
            child: Text("${posting.price.toInt()} PLN"),
          )
        ],
      ),
    );

    var gestureDetector = GestureDetector(
      onTap: onTap,
      child: marker,
    );

    return gestureDetector;
  }
}