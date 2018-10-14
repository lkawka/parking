import 'package:flutter/material.dart';
import 'package:parking/app_state.dart';
import 'package:parking/models/location.dart';
import 'package:parking/models/posting.dart';
import 'package:parking/screens/profile/widgets/posted_cell/index.dart';
import 'package:parking/screens/profile/widgets/rent_cell/index.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(text: "Rented"),
            Tab(text: "Posted"),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          rentedTab(),
          postedTab()
        ],
      ),
    );

    var tabBarController = DefaultTabController(
      length: 2,
      child: scaffold,
    );

    return tabBarController;
  }

  Widget rentedTab() {
    var postings = <Posting>[
      Posting(title: "Cheap",
          price: 35.0,
          location: Location(title: "loc1", lat: 52.210741, lng: 21.011951)),
      Posting(title: "Free",
          price: 0.0,
          location: Location(title: "loc2", lat: 52.226374, lng: 21.000665)),
      Posting(title: "Available",
          price: 120.0,
          location: Location(title: "loc3", lat: 52.253770, lng: 21.001314)),
    ];

    var cells = <Widget>[];
    postings.forEach((posting) => cells.add(RentCell(posting)));

    var listView = ListView(
      children: cells,
    );

    var container = Container(
      padding: EdgeInsets.all(15.0),
      child: listView,
    );

    return container;
  }

  Widget postedTab() {
    AppState appState = AppState.of(context);

    var stream = StreamBuilder(
        stream: appState.parkSpotManager.active,
        builder: (context, snapshot) {
//          var postings = <Posting>[
//            Posting(title: "Cheap",
//                price: 35.0,
//                location: Location(title: "loc1", lat: 52.210741, lng: 21.011951)),
//            Posting(title: "Free",
//                price: 0.0,
//                location: Location(title: "loc2", lat: 52.226374, lng: 21.000665)),
//            Posting(title: "Available",
//                price: 120.0,
//                location: Location(title: "loc3", lat: 52.253770, lng: 21.001314)),
//          ];

          List<Posting> postings = snapshot.data;
          if (postings == null) {
            postings = [];
          }

          var cells = <Widget>[];
          postings.forEach((posting) =>
              cells.add(GestureDetector(
                onTap: () {
                  //TODO implement later
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) {
//                            return PostedDetails();
//                          }
//                      )
//                  );
                },
                child: PostedCell(posting),
              )));

          var listView = ListView(
            children: cells,
          );

          var container = Container(
            padding: EdgeInsets.all(15.0),
            child: listView,
          );

          return container;
        }
    );

    return stream;
  }
}
