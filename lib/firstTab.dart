import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CreateEvent.dart';
import 'EventDetails.dart';
import 'package:cugo_project/Event.dart';

class FirstTab extends StatefulWidget {
  const FirstTab(this.uid);
   final String uid;

  @override
  State<StatefulWidget> createState() => new _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  
  @override
  Widget build(BuildContext context) {
    var eventTimeFormat = new DateFormat("jm");
    var eventDateFormat = new DateFormat("MMMd");

    return new StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection('events').orderBy('date').snapshots(),
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
                  Positioned(
                      bottom: 40,
                      left: 20,
                      child: RaisedButton(
                        child: Icon(Icons.add, color: Colors.white),
                        onPressed: _createNewEvent,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Theme.of(context).accentColor,
                      ))
                ]),
              );
          }
        });
  }

 void _createNewEvent() {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateEvent(widget.uid)),
    );
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

    _showEventPage(currEvent);
  }

  void _showEventPage(Event currEvent) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetails(currEvent: currEvent, uid: widget.uid,)),
    );
  }
}
