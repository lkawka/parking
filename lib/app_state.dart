import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/location.dart';
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
  final _activeController = BehaviorSubject<List<Posting>>(
      seedValue: <Posting>[Posting(title: "-",
          price: 0.0,
          location: Location(lat: 80.1, lng: 30.1, title: "Ulica"))
      ]
  );

  Stream<int> get selected => _selectedController.stream;
  final _selectedController = BehaviorSubject<int>(seedValue: null);

  ParkSpotManager({this.reference}) {
    reference.onChildAdded.listen(
            (event) {
          Posting p = Posting.fromSnapshot(event.snapshot);
          parkSpotList.add(p);
          _activeController.add(parkSpotList);
        }
    );

    _selectedController.add(-1);
  }

  postNewPosting(Posting posting) {
    reference.push().set(posting.toJson());
  }

  changeSelected(int i) {
    _selectedController.add(i);
  }

}
