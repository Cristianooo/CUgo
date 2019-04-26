import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cugo_project/ProfilePageFiles/EditInformation.dart';
import 'dart:async';

class MyEventDetails extends StatefulWidget {
  final String documentID;

  const MyEventDetails({this.documentID});
  @override
  State<StatefulWidget> createState() => new _MyEventDetails();
}

class _MyEventDetails extends State<MyEventDetails> {
  DocumentSnapshot _eventDocument;

  Future<DocumentSnapshot> _getEventData() async {
    DocumentSnapshot event = await Firestore.instance
        .collection('events')
        .document(widget.documentID)
        .get();
    _eventDocument = event;
    return _eventDocument;
  }

  final eventDayFormat = new DateFormat("yMMMMd");
  final eventTimeFormat = new DateFormat("jm");

  bool beABuddy = false;
  bool haveABuddy = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          actions: <Widget>[
            new FlatButton(
                child: new Text("Edit Information",
                    style: TextStyle(color: Colors.white)),
                onPressed: _findDocToEdit),
          ],
        ),
        body: new FutureBuilder(
          future: _getEventData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new LinearProgressIndicator();
              case ConnectionState.done:
                return new Material(
                    child: Stack(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Color(0xFFA50034)),
                        child: new Padding(
                            padding: EdgeInsets.all(30),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('What is it?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        color: Colors.white)),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 40.0),
                                  child: Text(snapshot.data['name'],
                                      style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                Text('Where is it?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        color: Colors.white)),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 40.0),
                                  child: Text(snapshot.data['location'],
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text('When is it?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        color: Colors.white)),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          eventDayFormat.format(
                                              snapshot.data['date'].toDate()),
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left),
                                      Text(
                                          ' @ ' +
                                              eventTimeFormat.format(snapshot
                                                  .data['date']
                                                  .toDate()),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white))
                                    ],
                                  ),
                                ),
                              ],
                            ))),
                    Positioned(
                        top: MediaQuery.of(context).size.height / 3,
                        child: Container(
                            height: MediaQuery.of(context).size.height / 1.8,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 50.0, left: 30.0, right: 20.0),
                              child: ListView(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'About',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 40.0),
                                    child: Text(
                                      snapshot.data['description'],
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text('Accessibility',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 40.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(FontAwesomeIcons.wheelchair),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Icon(FontAwesomeIcons.blind),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Icon(FontAwesomeIcons.deaf),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            )))
                  ],
                ));
                break;
              default: 
                if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return new Text('Result: ${snapshot.data}');
            }
          },
        ));
  }

  void _findDocToEdit() {
    Firestore.instance
        .collection('events')
        .document(widget.documentID)
        .get()
        .then((DocumentSnapshot ds) {
      _editInfo(ds);
    });
  }

  void _editInfo(DocumentSnapshot documentSnap) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditInformation(document: documentSnap)),
    );
  }
}
