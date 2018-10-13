import 'package:flutter/material.dart';
import 'package:parking/app_state.dart';
import 'package:parking/screens/tab_bar/index.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppState(
        child: Theme(
          data: ThemeData(
            primaryColor: Colors.redAccent,
            splashColor: Colors.greenAccent,
          ),
          child: MaterialApp(
            //debugShowCheckedModeBanner: true,
            home: TabBarScreen(),
          ),
        )
    );
  }
}