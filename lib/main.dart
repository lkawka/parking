import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking/app_state.dart';
import 'package:parking/screens/tab_bar/index.dart';

Future<void> main() async {
  FirebaseApp app = await FirebaseApp.configure(
      name: "db",
      options:
      FirebaseOptions(
        googleAppID: "1:211261918882:android:5eed423c299aaed1",
        databaseURL: "https://parking-484a9.firebaseio.com",
        apiKey: "AIzaSyA0ESdzJscjbKry1qvsytEsw3pd1RqDZw8",
      )
  );

  runApp(new MyApp(db: app,));
}

class MyApp extends StatelessWidget {

  FirebaseApp db;

  MyApp({this.db});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppState(
      fbapp: db,
      child: MaterialApp(
        //debugShowCheckedModeBanner: true,
        home: TabBarScreen(),
      ),
    );
  }
}