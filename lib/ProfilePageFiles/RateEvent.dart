import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cugo_project/Event.dart';
import 'package:cugo_project/ProfilePageFiles/EditInformation.dart';
import 'dart:async';

class RateEvent extends StatefulWidget {
  final Event currEvent;

  const RateEvent({this.currEvent});
  @override
  State<StatefulWidget> createState() => new _RateEvent();
}

class _RateEvent extends State<RateEvent> {
  int groupValue;


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
                            padding: EdgeInsets.all(20),
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
                                          eventDayFormat.format(
                                              widget.currEvent.date.toDate()),
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
                        top: MediaQuery.of(context).size.height / 3.4,
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
                                  top: 40.0, left: 30.0, right: 20.0),
                              child: ListView(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      'Event Review',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 25.0),
                                    child: Text(
                                      'Please respond to the following statements about the recent event you attended',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 25.0),
                                    child: Text(
                                      'I felt comfortable at this Event',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          Radio(
                                            activeColor: Color(0xFFA50034),
                                            value: 1,
                                            groupValue: groupValue,
                                            onChanged: (int gv) => eradicateTheSenate(gv),

                                          ),
                                          Radio(
                                            activeColor: Color(0xFFA50034),
                                            value: 2,
                                            groupValue: groupValue,
                                            onChanged: (int gv) => eradicateTheSenate(gv),
                                          ),
                                          Radio(
                                            activeColor: Color(0xFFA50034),
                                            value: 3,
                                            groupValue: groupValue,
                                            onChanged: (int gv) => eradicateTheSenate(gv),
                                          ),
                                          Radio(
                                            activeColor: Color(0xFFA50034),
                                            value: 4,
                                            groupValue: groupValue,
                                            onChanged: (int gv) => eradicateTheSenate(gv),
                                          ),
                                          Radio(
                                            activeColor: Color(0xFFA50034),
                                            value: 5,
                                            groupValue: groupValue,
                                            onChanged: (int gv) => eradicateTheSenate(gv),
                                          )
                                        ],

                                      )
                                      
                                      
                                  
                                  ),
                                  
                                ],
                              ),
                            )))
                  ],
                ))
        );
  }

  void eradicateTheSenate(int gov)
  {
    setState(() {
      if (gov==1)
      {
        groupValue = 1;
      }
      else if (gov==2)
      {
        groupValue = 2;
      }
      else if(gov==3)
      {
        groupValue = 3;
      }
      else if(gov==4)
      {
        groupValue = 4;
      }
      else if(gov==5)
      {
        groupValue = 5;
      }
    });
  }
}
