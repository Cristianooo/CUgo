
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                                
                                _showEventPage(document);
                              }),
                          ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Text(eventTimeFormat
                                  .format(document['date'].toDate())),
                              onTap: () {
                               
                               _showEventPage(document);
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

  void _showEventPage(DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEventDetails(documentID: document.documentID)),
    );
  }


}