import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:parking/widgets/marker/index.dart';
import 'package:parking/models/posting.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _selectedPosting;

  @override
  Widget build(BuildContext context) {

    var postings = [
      Posting(title: "Cheap", price: 35.0, lat: 52.210741, lng: 21.011951),
      Posting(title: "Free", price: 0.0, lat: 52.226374, lng: 21.000665),
      Posting(title: "Available", price: 120.0, lat: 52.253770, lng: 21.001314),
    ];

    var markers = <Marker> [];
    for (int i = 0; i < postings.length; i++) {
      markers.add(Marker(
        height: 35.0,
        width: 80.0,
        point: LatLng(postings[i].lat, postings[i].lng),
        builder: (context) {
          return MyMarker(
            isHighlighted: _selectedPosting != null && _selectedPosting == i ? true : false,
            title: postings[i].price.toInt().toString(),
            onTap: () {
              setState(() {
                _selectedPosting = i;
              });
            },
          );
        }
      ));
    }


    var map = Container(
      child: FlutterMap(
        options: new MapOptions(
          center: new LatLng(52.229651, 21.012187),
          zoom: 12.0,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoiYmFsbG1lcnBlYWsiLCJhIjoiY2puN2NyZXNmMDd1ZzNwcGt4b2l6NGM0byJ9.IJRIrrcLWT-8HO5YkVY1Ow',
              'id': 'mapbox.streets',
            },
          ),
          new MarkerLayerOptions(
            markers: markers,
          )
        ]
      ),
    );

    var safeArea = SafeArea(
      top: false,
      child: map,
    );

    var scaffold = Scaffold(
      body: safeArea,
    );

    return scaffold;
  }

}