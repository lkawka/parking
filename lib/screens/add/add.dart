import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String _title;
  double _price;
  int _radioValue = 0;
  String info;

  _handleRadioButtons(val) {
    setState(() {
      _radioValue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var titleField = Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Title",
        ),
      ),
    );

    var priceField = Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Price",
        ),
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
      ),
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
        typeField,
        infoField,
        Container(
          height: 15.0,
        ),
      ],
    );

    var form = Container(
      padding:
          EdgeInsets.only(top: 25.0, bottom: 25.0, left: 20.0, right: 20.0),
      child: Form(
        autovalidate: false,
        child: listView,
      ),
    );

    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        backgroundColor: Colors.grey,
      ),
      body: form,
    );

    return scaffold;
  }
}
