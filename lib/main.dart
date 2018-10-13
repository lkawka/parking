import 'package:flutter/material.dart';
import 'package:parking/app_state.dart';
import 'package:parking/back_drop.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppState(
      child: MaterialApp(
        //debugShowCheckedModeBanner: true,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: BackdropScaffold(

          ///TUTAJ DEJ MAPE
          backpanel: Container(color: Colors.green,),

            ///TUTAJ JEST BACK DROP
            body: ListView.builder(
              itemBuilder: (index, context) {
                return Text("siema");
              },
              itemCount: 30,
            )
        )
    );
  }

}
