
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cugo_project/ProfilePageFiles/RateEvent.dart';
import 'package:cugo_project/Event.dart';


class MyPastEvents extends StatefulWidget {
  final String userUID;

  const MyPastEvents({this.userUID});

  @override
  State<StatefulWidget> createState() => new _MyPastEventState();
}

class _MyPastEventState extends State<MyPastEvents> {
  
  @override
  Widget build(BuildContext context) {
    var eventTimeFormat = new DateFormat("jm");
    var eventDateFormat = new DateFormat("MMMd");

    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection('events').where('usersSigned', arrayContains: widget.userUID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  new ListView(
                    padding: EdgeInsets.all(16.0),
                    shrinkWrap: true,
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return new Center(
                          child: Card(
                              child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              leading: new Text(eventDateFormat
                                  .format(document['date'].toDate())),
                              title: new Text(document['name']),
                              subtitle: new Text(document['description']),
                              onTap: () {
                                
                                _createEvent(document);
                              }),
                          ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Text(eventTimeFormat
                                  .format(document['date'].toDate())),
                              onTap: () {
                               
                               _createEvent(document);
                              }),
                        ],
                      )));
                    }).toList(),
                  ),
                ]),
              );
          }
        })

    );
    
    
  }

  void _showRatePage(Event currEvent) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RateEvent(currEvent: currEvent)),
    );
  }

  String monthAndDay(DateTime date) {
    String mdFinal = "";
    if (date.day < 10 && date.month < 10)
    {
      mdFinal = "0" + date.month.toString() + "0" + date.day.toString();
    }
    else if (date.day < 10 && date.month > 10)
    {
      mdFinal = date.month.toString() + "0" + date.day.toString();
    }
    else if (date.day > 10 && date.month < 10)
    {
      mdFinal = "0" + date.month.toString() + date.day.toString();
    }
    else{
      mdFinal = date.month.toString() + date.day.toString();
    }
    return mdFinal;
  }

  void _createEvent(DocumentSnapshot document) {

    Event currEvent = Event(name: document['name'], 
    description: document['description'], 
    date: document['date'], 
    location: document['location'], 
    documentID: document.documentID,
    createdBy: document['createdBy'],
    wheelchairAccess: document['wheelchairAccess'],
    seeingAccess: document['seeingAccess'],
    hearingAccess: document['hearingAccess']
    );

    _showRatePage(currEvent);
  }


}