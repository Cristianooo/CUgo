import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetails extends StatefulWidget {
  final Event myEvent;
  final String uid;

  const EventDetails({this.myEvent, this.uid});
  @override
  State<StatefulWidget> createState() => new _EventDetails();
}

class _EventDetails extends State<EventDetails> {
  final eventDayFormat = new DateFormat("yMMMMd");
  final eventTimeFormat = new DateFormat("jm");

  bool beABuddy = false;
  bool haveABuddy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          actions: <Widget>[
            new FlatButton(
              child: new Text("Incorrect Event Details?",
                  style: TextStyle(color: Colors.white)),
              onPressed: null,
            ),
          ],
        ),
        body: new Material(
            child: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.blue),
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
                          child: Text(widget.myEvent.name,
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
                          child: Text(widget.myEvent.location,
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
                                  eventDayFormat
                                      .format(widget.myEvent.date.toDate()),
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left),
                              Text(
                                  ' @ ' +
                                      eventTimeFormat
                                          .format(widget.myEvent.date.toDate()),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))
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
                      padding:
                          EdgeInsets.only(top: 50.0, left: 30.0, right: 20.0),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'About',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 40.0),
                            child: Text(
                              widget.myEvent.description,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text('Accessibility',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 40.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.wheelchair),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Icon(FontAwesomeIcons.blind),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Icon(FontAwesomeIcons.deaf),
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: beABuddy,
                                  onChanged: (bool value) {
                                    setState(() {
                                      beABuddy = value;
                                    });
                                  },
                                ),
                                Text('Be a Buddy'),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: haveABuddy,
                                onChanged: (bool value) {
                                  setState(() {
                                    haveABuddy = value;
                                  });
                                },
                              ),
                              Text('Have a Buddy')
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 40.0),
                                child: FlatButton(
                                  child: Text('Whats the Difference?', style: TextStyle(color: Colors.grey)),
                                  onPressed: null,
                                )),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text('Sign Up',
                                style: TextStyle(color: Colors.white)),
                            onPressed: signUp,
                          )
                        ],
                      ),
                    )))
          ],
        )));
  }
void signUp(){
  Firestore.instance.collection('events').document(widget.myEvent.documentID).collection('usersGoing').document().setData({
    'UID': widget.uid
  });
}


}


