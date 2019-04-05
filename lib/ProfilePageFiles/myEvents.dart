
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cugo_project/Event.dart';
import 'package:cugo_project/ProfilePageFiles/MyEventDetails.dart';


class MyEvents extends StatefulWidget {
  final String userUID;

  const MyEvents({this.userUID});

  @override
  State<StatefulWidget> createState() => new _MyEventState();
}

class _MyEventState extends State<MyEvents> {
  
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
            Firestore.instance.collection('events').where('createdBy', isEqualTo: widget.userUID).orderBy('date').snapshots(),
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
                                
                                _showEventPage(document.documentID);
                              }),
                          ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Text(eventTimeFormat
                                  .format(document['date'].toDate())),
                              onTap: () {
                               
                               _showEventPage(document.documentID);
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
  String eventLocation = "";
  void assignAndCreateEvent(DocumentSnapshot document) {
    if (document['location'] == GeoPoint(33.792895, -117.851275)) {
      eventLocation = "Leatherby Libraries";
    } else if (document['location'] == GeoPoint(33.792995, -117.850680)) {
      eventLocation = "Argyros Forum";
    }else if (document['location'] == GeoPoint(33.794054, -117.850903)) {
      eventLocation = "Ernie Chapman Stadium";
    }else if (document['location'] == GeoPoint(33.791995, -117.852535)) {
      eventLocation = "Memorial Lawn";
    }else if (document['location'] == GeoPoint(33.792895, -117.851275)) {
      eventLocation = "Memorial Hall";
    }else if (document['location'] == GeoPoint(33.793709, -117.852212)) {
      eventLocation = "FISH Interfaith Center";
    }else if (document['location'] == GeoPoint(33.793061, -117.851753)) {
      eventLocation = "Atallah Piazza";
    }else if (document['location'] == GeoPoint(33.792280, -117.850732)) {
      eventLocation = "Irvine Lecture Hall";
    }else if (document['location'] == GeoPoint(33.794164, -117.852634)) {
      eventLocation = "Musco Center for the Arts";
    }
    //Event myEvent = new Event(document['name'], document['description'],
    //    document['date'], eventLocation, document.documentID, document['createdBy']);
   // _showEventPage(myEvent);

  }
  void _showEventPage(String documentID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEventDetails(documentID: documentID,)),
    );
  }


}