import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:parking/app_state.dart';
import 'package:parking/models/posting.dart';
import 'package:parking/widgets/marker/index.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _selectedPosting;

  @override
  Widget build(BuildContext context) {
    AppState appState = AppState.of(context);

    getMarkers(List<Posting> postings) {
      var markers = <Marker>[];

      for (int i = 0; i < postings.length; i++) {
        markers.add(Marker(
            height: 35.0,
            width: 80.0,
            point: LatLng(postings[i].lat, postings[i].lng),
            builder: (context) {
              return MyMarker(
                isHighlighted: _selectedPosting != null && _selectedPosting == i
                    ? true
                    : false,
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

      return markers;

    }


    var map = Container(
        child: StreamBuilder(
          stream: appState.parkSpotManager.active,
          builder: (context, snapshot) {
            return FlutterMap(
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
                    markers: getMarkers(snapshot.data),
                  )
                ]
            );
          },
        )
    );

    var scaffold = Scaffold(
      body: map,
    );

    return scaffold;
  }

}