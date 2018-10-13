import 'package:flutter/material.dart';

class MyMarker extends StatelessWidget {

  final isHighlighted;
  final onTap;

  MyMarker({Key key, this.isHighlighted = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    var container = Container(
      height: 20.0,
      width: 20.0,
      color: isHighlighted ? Colors.redAccent : Colors.lightBlue,
    );

    var gestureDetector = GestureDetector(
      onTap: onTap,
      child: container,
    );

    return gestureDetector;
  }
}