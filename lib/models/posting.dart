import 'package:firebase_database/firebase_database.dart';
import 'package:parking/models/location.dart';

class Posting {
  String key;

  String title;
  double price;

  Location location;

  String type; //SMALL, MEDIUM or BIG

  List<DateTime> rented = [];

  Posting({this.title, this.price, this.location, this.type});

  Posting.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        price = double.tryParse(snapshot.value["price"].toString()),
        type = snapshot.value["type"],
        location = Location(
          title: snapshot.value["locationTitle"],
          lat: snapshot.value["lat"],
          lng: snapshot.value["lng"],
        );

  toJson() {
    return {
      "title": title,
      "price": price,
      "type": type,
      "locationTitle": location.title,
      "lat": location.lat,
      "lng": location.lng,
    };
  }

}

