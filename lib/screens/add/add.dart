import 'package:flutter/material.dart';
import 'package:parking/app_state.dart';
import 'package:parking/models/location.dart';
import 'package:parking/models/posting.dart';
import 'package:parking/screens/location/index.dart';


class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}


class _AddScreenState extends State<AddScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _title;
  double _price;
  Location _location = Location(
      title: "Startberry, Grochowska 306/308, Warszawa",
      lat: 52.210777,
      lng: 21.011922);
  int _radioValue = 0;
  String _info;

  _handleRadioButtons(val) {
    setState(() {
      _radioValue = val;
    });
  }

  postPosting(AppState state) {

    if (_formKey.currentState.validate() && _location != null) {
      _formKey.currentState.save();
    } else {
      return;
    }

    String type;
    switch (_radioValue) {
      case 0:
        type = "SMALL";
        break;
      case 1:
        type = "MEDIUM";
        break;
      case 2:
        type = "BIG";
        break;
    }

    var posting = Posting(
      title: _title,
      price: _price,
      location: _location,
      type: type,
      ocupiedList: Occupied(),
    );

    state.parkSpotManager.postNewPosting(posting);
  }

  @override
  Widget build(BuildContext context) {
    var titleField = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Title",
        ),
        onSaved: (val) {
          _title = val;
        },
        validator: (val) {
          if (val == null || val.length == 0) {
            return "This field cannot be left empty";
          }
          return null;
        },
      ),
    );

    var priceField = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Price",
        ),
        onSaved: (val) {
          _price = num.tryParse(val).toDouble();
        },
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        validator: (val) {
          if (val == null || val.length == 0) {
            return "This field cannot be left empty";
          }
          return null;
        },
      ),
    );

    var locationField = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Location",
            style: TextStyle(fontSize: 17.0),
          ),
          Container(
            height: 7.0,
          ),
          GestureDetector(
            onTap: () async {
              _location = await Navigator.push(
                  context,
                  MaterialPageRoute<Location>(
                      builder: (BuildContext context) {
                        return LocationScreen();
                      }
                  )
              );
            },
            child: Text(
              _location != null ? _location.title : "No location selected",
              style: TextStyle(fontSize: 17.0),),
          )
        ],
      ),
    );

    var typeField = Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Type",
              style: TextStyle(fontSize: 17.0),
            ),
            Container(
              height: 7.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: (val) {
                        _handleRadioButtons(val);
                      },
                    ),
                    Text("Small"),
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: (val) {
                        _handleRadioButtons(val);
                      },
                    ),
                    Text("Medium"),
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: (val) {
                        _handleRadioButtons(val);
                      },
                    ),
                    Text("Big"),
                  ],
                ),
              ),
            )
          ],
        ));

    var infoField = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: "Info"),
        onSaved: (val) {
          _info = val;
        },
      ),
    );

    var postButton = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: RaisedButton(
        child: Text("Post"),
        onPressed: () {
          postPosting(AppState.of(context));
        },
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );

    var listView = ListView(
      children: <Widget>[
        titleField,
        priceField,
        Container(
          height: 10.0,
        ),
        locationField,
        Container(
          height: 10.0,
        ),
        typeField,
        infoField,
        Container(
          height: 15.0,
        ),
        postButton,
        Container(height: 20.0,),
      ],
    );

    var form = Container(
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Container(
          child: listView,
        ),
      ),
    );

    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Add new parking spot"),
      ),
      body: form,
      resizeToAvoidBottomPadding: false,
    );

    return scaffold;
  }
}
