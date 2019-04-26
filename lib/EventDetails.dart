import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'incorrectDetails.dart';
import 'package:cugo_project/BuddyExplanation.dart';
import 'package:cugo_project/Event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetails extends StatefulWidget {
  final Event currEvent;
  final String uid;

  const EventDetails({this.currEvent, this.uid});
  @override
  State<StatefulWidget> createState() => new _EventDetails();
}

class _EventDetails extends State<EventDetails> {
  final eventDayFormat = new DateFormat("yMMMMd");
  final eventTimeFormat = new DateFormat("jm");

  bool beABuddy = false;
  bool haveABuddy = false;

  Future<bool> _checkIfSignedUp() async{
    final QuerySnapshot result = await Firestore.instance
    .collection('events')
    .document(widget.currEvent.documentID)
    .collection('usersGoing')
    .where('UID', isEqualTo: widget.uid)
    .limit(1)
    .getDocuments();

    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  void _incorrectDetails() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => IncorrectDetails()));
  }

  void _buddyExplanation() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BuddyExplanation()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          actions: <Widget>[
            new FlatButton(
              child: new Text("Incorrect Event Details?",
                  style: TextStyle(color: Colors.white)),
              onPressed: _incorrectDetails,
            ),
          ],
        ),
        body: new Material(
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
                                    child: Text(widget.currEvent.name,
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
                                    child: Text(widget.currEvent.location,
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
                                            eventDayFormat.format(widget.currEvent.date
                                                .toDate()),
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left),
                                        Text(
                                            ' @ ' +
                                                eventTimeFormat.format(widget.currEvent.date
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
                                padding:
                                    EdgeInsets.only(left: 30.0, right: 20.0),
                                child: ListView(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 50)),
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
                                        widget.currEvent.description,
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
                                    Container(
                                      child: _buildLogos()
                                    ),
                                    
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
                                          padding:
                                              EdgeInsets.only(bottom: 40.0),
                                          child: FlatButton(
                                            child: Text('What\'s a Buddy?',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            onPressed: _buddyExplanation,
                                          )),
                                    ),
                                    _buildSignUpButton()
                                  ],
                                ),
                              )))
                    ],
            )
        )
      );
  }  

Widget _buildSignUpButton(){
      return( FutureBuilder(
        future: _checkIfSignedUp(),
        builder: (context, AsyncSnapshot<bool> result){
          if (!result.hasData)
            return Container(); 
          if(!result.data){
            return RaisedButton(
          color: Color(0xFFA50034),
          child: Text('Sign Up',
              style:
                  TextStyle(color: Colors.white)),
          onPressed:(){
            signUp();
            setState(() {
                        
                        });
            }
        );
          }
          else {
            return RaisedButton(
          color: Color(0xFFA50034),
          child: Text('Sign Up',
              style:
                  TextStyle(color: Colors.white)),
          onPressed:null
        );
          }
        }

      )
        
      );
  
}

  Widget _buildLogos() {
    return Padding(
    padding: EdgeInsets.only(bottom: 40.0),
    child: Row(
      children: <Widget>[
        _checkWheelchairLogo(widget.currEvent.wheelchairAccess),
        Padding(
          padding:
              EdgeInsets.only(left: 10.0),
          child:
              _checkBlindLogo(widget.currEvent.seeingAccess),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 10.0),
          child:
              _checkHearingLogo(widget.currEvent.hearingAccess),
        )
      ],
    ));
  }

  Widget _checkWheelchairLogo(bool wheelchairBool) {
    if(wheelchairBool){
      return(Icon(FontAwesomeIcons.wheelchair));
    }
    return(Icon(FontAwesomeIcons.wheelchair, color: Colors.grey));
  }
  Widget _checkBlindLogo(bool seeingBool) {
    if(seeingBool){
      return(Icon(FontAwesomeIcons.blind));
    }
    return(Icon(FontAwesomeIcons.blind, color: Colors.grey));
  }
  Widget _checkHearingLogo(bool hearingBool) {
    if(hearingBool){
      return(Icon(FontAwesomeIcons.deaf));
    }
    return(Icon(FontAwesomeIcons.deaf, color: Colors.grey));
  }

  void signUp() {
    Firestore.instance
        .collection('events')
        .document(widget.currEvent.documentID)
        .collection('usersGoing')
        .document()
        .setData({'UID': widget.uid});
  }
}
