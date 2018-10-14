import 'package:flutter/material.dart';
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

  postPosting() {
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
        type: type
    );

    //TODO do something with the posting
  }

  @override
  Widget build(BuildContext context) {
    var titleField = Container(
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
                    Text("small"),
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: (val) {
                        _handleRadioButtons(val);
                      },
                    ),
                    Text("medium"),
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: (val) {
                        _handleRadioButtons(val);
                      },
                    ),
                    Text("big"),
                  ],
                ),
              ),
            )
          ],
        ));

    var infoField = Container(
      child: TextFormField(
        decoration: InputDecoration(labelText: "Info"),
        onSaved: (val) {
          _info = val;
        },
      ),
    );

    var postButton = RaisedButton(
      child: Text("Post"),
      onPressed: postPosting,
    );

    var listView = ListView(
      children: <Widget>[
        Container(
          height: 0.1,
        ),
        titleField,
        priceField,
        Container(
          height: 5.0,
        ),
        locationField,
        Container(
          height: 5.0,
        ),
        typeField,
        infoField,
        Container(
          height: 7.0,
        ),
        postButton,
      ],
    );

    var form = Container(
      padding:
      EdgeInsets.only(top: 25.0, bottom: 25.0, left: 20.0, right: 20.0),
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
        title: Text("Add"),
      ),
      body: form,
      resizeToAvoidBottomPadding: false,
    );

    return scaffold;
  }
}
