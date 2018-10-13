import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/posting.dart';
import 'package:rxdart/rxdart.dart';

class AppState extends InheritedWidget {

  FirebaseDatabase database;
  ParkSpotManager parkSpotManager;

  AppState({
    FirebaseApp fbapp,
    Key key,
    Widget child,
  }) : super(key: key, child: child) {
    database = FirebaseDatabase(app: fbapp);
    parkSpotManager =
        ParkSpotManager(reference: database.reference().child('parkings'));
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static AppState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppState);
  }

}

class ParkSpotManager {

  DatabaseReference reference;

  List<Posting> parkSpotList = List<Posting>();

  Stream<List<Posting>> get active => _activeController.stream;
  final _activeController = BehaviorSubject<List<Posting>>(seedValue: null);

  ParkSpotManager({this.reference}) {
    reference.onChildAdded.listen(
            (event) {
          Posting p = Posting.fromSnapshot(event.snapshot);
          parkSpotList.add(p);
          _activeController.add(parkSpotList);
        }
    );
  }

}
