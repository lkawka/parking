import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking/app_state.dart';
import 'package:parking/screens/add/index.dart';
import 'package:parking/screens/backdrop/index.dart';
import 'package:parking/screens/map/index.dart';
import 'package:parking/screens/profile/index.dart';
import 'package:parking/widgets/info_details/index.dart';
import 'package:parking/widgets/info_details/info_details.dart';

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    var screens = [
      BackdropScaffold(
        headerHeight: 0.0,
        backpanel: MapScreen(),
        body: StreamBuilder(
            stream: AppState
                .of(context)
                .parkSpotManager
                .selected,
            builder: (context, snapshot) {
              AppState appState = AppState.of(context);
              if (snapshot.data != null && snapshot.data > -1 &&
                  appState.parkSpotManager.parkSpotList.length >
                      snapshot.data) {
                return InfoDetails(
                    posting: appState.parkSpotManager.parkSpotList[snapshot
                        .data]);
              } else {
                return Container();
              }
            }
        ),
      ),
      AddScreen(),
      ProfileScreen(),
    ];

    // Sets icons in task bar to black on iOS
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    var scaffold = Scaffold(
        body: screens[_selectedScreen],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreen,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text("Add"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profile"),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedScreen = index;
            });
          },
        ));

    var safeArea = SafeArea(
      top: false,
      bottom: false,
      child: scaffold,
    );

    return safeArea;
  }
}
