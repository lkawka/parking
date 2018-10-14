import 'package:firebase_database/firebase_database.dart';
import 'package:parking/models/location.dart';

class Posting {
  String key;

  String title;
  double price;

  Location location;

  Occupied ocupiedList;

  String type; //SMALL, MEDIUM or BIG

  Posting({this.title, this.price, this.location, this.type, this.ocupiedList});

  Posting.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        price = double.tryParse(snapshot.value["price"].toString()),
        location = Location(
          title: snapshot.value["locationTitle"],
          lat: snapshot.value["lat"],
          lng: snapshot.value["lng"],
        );

  toJson() {
    return {
      "title": title,
      "price": price,
      "locationTitle": location.title,
      "lat": location.lat,
      "lng": location.lng,
    };
  }

}

class Occupied {

  int start;
  int end;

  Occupied({this.start: -1, this.end: -1});

}

