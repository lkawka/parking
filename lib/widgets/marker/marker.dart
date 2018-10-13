import 'package:flutter/material.dart';

class MyMarker extends StatelessWidget {

  final isHighlighted;
  final title;
  final onTap;

  MyMarker({Key key, this.title = "Free", this.isHighlighted = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    var marker = Container(
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.white : Colors.white70 ,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//        border: isHighlighted ? Border.all(color: Colors.black12) : null,
      ),
      child: Row(
        children: <Widget>[
          Image.asset("assets/money-icon.png"),
          Expanded(
            child: Text("$title PLN"),
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