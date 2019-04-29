/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CreateEvent.dart';
import 'Event.dart';

class EventCalendarAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EventCalendarAdd();
}

class _EventCalendarAdd extends State<EventCalendarAdd> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var eventTimeFormat = new DateFormat("jm");
    var eventDateFormat = new DateFormat("MMMd");
    var selectedDate = new DateTime();

    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('events').where('date', isEqualTo:  ).orderBy('date').snapshots(),
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
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
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
                                Event myEvent = new Event(
                                    document['name'],
                                    document['description'],
                                    document['date'],
                                    document['location']);
                                _showEventPage(myEvent);
                              }),
                          ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Text(eventTimeFormat
                                  .format(document['date'].toDate()))),
                        ],
                      )));
                    }).toList(),
                  ),
                  Positioned(
                      bottom: 40,
                      left: 20,
                      child: RaisedButton(
                        child: Icon(Icons.add, color: Colors.white),
                        onPressed: _showModalSheet,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Theme.of(context).accentColor,
                      ))
                ]),
              );
          }
        });
  }
}*/