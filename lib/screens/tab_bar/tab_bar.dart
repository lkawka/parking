import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking/screens/add/index.dart';
import 'package:parking/screens/backdrop/index.dart';
import 'package:parking/screens/map/index.dart';
import 'package:parking/screens/profile/index.dart';

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
          backpanel: MapScreen(),
          body: Container(color: Colors.blue,)
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
