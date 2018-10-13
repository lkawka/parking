import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  AppState({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

}
