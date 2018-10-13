import 'package:firebase_database/firebase_database.dart';

class Posting {
  String key;

  String title;
  double price;

  double lat;
  double lng;

  Posting({this.title, this.price, this.lat, this.lng});

  Posting.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        price = double.tryParse(snapshot.value["price"].toString()),
        lat = snapshot.value["lat"],
        lng = snapshot.value["lng"];

  toJson() {
    return {
      "title": title,
      "price": price,
      "lat": lat,
      "lng": lng,
    };
  }

}