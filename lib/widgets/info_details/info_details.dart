import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:parking/app_state.dart';
import 'package:parking/models/posting.dart';

class InfoDetails extends StatefulWidget {

  Posting posting;
  Posting newPosting;

  int start = 8;
  int end = 16;

  InfoDetails({this.posting}) {
    newPosting = posting;
  }

  @override
  State<StatefulWidget> createState() => InfoDetailsState();

}

class InfoDetailsState extends State<InfoDetails> {

  @override
  Widget build(BuildContext context) {
    // ignore: not_enough_required_arguments
    AppState
        .of(context)
        .parkSpotManager
        .reference
        .onChildChanged
        .listen((e) {
      setState(() {
        debugPrint("zmianakurwaczemu");
      });
    });
    return Container(
      padding: EdgeInsets.only(
          top: 20.0, left: 12.0, right: 12.0, bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /*Align(
            child: Text(widget.posting.title,style: TextStyle(fontSize: 22.0),),
            alignment: Alignment.center,
          ),*/
          Align(
            child: content("Ulica",
                Text(widget.posting.location.title,
                  style: TextStyle(fontSize: 18.0),)
            ),
            alignment: Alignment.bottomLeft,
          ),
          content(
              "Dostępność",
              Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: getfree(),
                      ),
                      /*Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Text("Wolne cały dzień",style: TextStyle(fontSize: 16.0),),
                  )*/
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: numbers(<int>[
                            widget.posting.ocupiedList.start,
                            widget.posting.ocupiedList.end
                          ]),
                        ),
                      )
                    ],
                  )
              )
          ),
          Divider(height: 0.0),
          Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Material(
                      color: Colors.blue,
                      elevation: 4.0,
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      child: InkWell(
                        splashColor: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16.0)),
                          ),
                          child: Text("Zarezerwuj", style: TextStyle(
                              color: Colors.white, fontSize: 20.0),),
                        ),
                        onTap: () {
                          widget.newPosting.ocupiedList.start = widget.start;
                          widget.newPosting.ocupiedList.end = widget.end;
                          AppState
                              .of(context)
                              .parkSpotManager
                              .updateParking(widget.posting);
                        },
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 64.0),
                    child: content(
                      "Od", Material(
                        color: Colors.white,
                        elevation: 4.0,
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: InkWell(
                          splashColor: Colors.blueGrey,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(16.0)),
                            ),
                            child: Text(widget.start.toString(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),),
                          ),
                          onTap: () => _showStart(context),
                        )
                    ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: content(
                      "Do", Material(
                        color: Colors.white,
                        elevation: 4.0,
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: InkWell(
                          splashColor: Colors.blueGrey,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(16.0)),
                            ),
                            child: Text(widget.end.toString(), style: TextStyle(
                                color: Colors.black, fontSize: 16.0),),
                          ),
                          onTap: () => _showEnd(context),
                        )
                    ),
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }

  Future _showStart(BuildContext context) async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 24,
          step: 1,
          initialIntegerValue: widget.start,
        );
      },
    ).then(_changeValStart);
  }

  Future _showEnd(BuildContext context) async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 24,
          step: 1,
          initialIntegerValue: widget.end,
        );
      },
    ).then(_changeValEnd);
  }

  _changeValStart(int val) {
    setState(() {
      widget.start = val;
    });
  }

  _changeValEnd(int val) {
    setState(() {
      widget.end = val;
    });
  }

  getListOfOccipied() {
    var list = <int>[];
    if (widget.posting.ocupiedList.start != null &&
        widget.posting.ocupiedList.start != -1) {
      for (int i = widget.posting.ocupiedList.start; widget.posting.ocupiedList
          .end > i; i++) {
        list.add(i);
      }
      list.add(widget.posting.ocupiedList.end);
    }
    return list;
  }

  List<Widget> getfree() {
    var list = <Widget>[];

    for (int i = 0; 24 > i; i++) {
      list.add(Container(
        padding: EdgeInsets.only(left: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getListOfOccipied().contains(i) ? Colors.grey : Colors.blue,
        ),
        height: 12.0,
        width: 12.0,
      ));
    }
    return list;
  }

  List<Widget> numbers(List<int> numbers) {
    var list = <Widget>[];

    for (int i = 0; 24 > i; i++) {
      list.add(Container(
        height: 12.0,
        width: 14.0,
        alignment: Alignment.center,
        child: numbers.contains(i) ? Text(
          (i).toString(), style: TextStyle(fontSize: 12.0),) : Container(),
      ));
    }
    return list;
  }

  Widget content(String title, Widget content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
          style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
        ),
        content
      ],
    );
  }

}
