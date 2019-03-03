import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CreateEvent.dart';
import 'Event.dart';

class FirstTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FirstTabState();
}

final myColor= const Color(0xff332D2D);
class _FirstTabState extends State<FirstTab> {

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final locationController = TextEditingController();

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new CreateEvent();
          
        });
  }
  void _showEventPage(Event myEvent){
     Navigator.push(
      context,
    MaterialPageRoute(builder: (context) => SecondRoute(myEvent)),
  );
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('events').snapshots(),
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
                      return new ListTile(
                        title: new Text(document['name']),
                        subtitle: new Text(document['description']),
                         
                        onTap:(){
                          Event myEvent = new Event(document['name'], document['description'], document['date'], document['location']);
                          _showEventPage(myEvent);
                        }
                      );
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
}
class SecondRoute extends StatelessWidget {
  final Event myEvent;
  SecondRoute(this.myEvent);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Padding(
              child: new Text("CU Go"),
              padding: const EdgeInsets.only(left: 20.0)),
            actions: <Widget>[
            new FlatButton(
              child:
                  new Text("Report Event", style: TextStyle(color: Colors.white)),
              onPressed: null,
            ),
          ],  
      ), 
      body: new Container(
        child : new Padding(
          padding: EdgeInsets.all(16),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(myEvent.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
         Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
          child: Row(
           children: <Widget>[
             Text('February 20  ', textAlign: TextAlign.left ),
             Text('7:00 pm', style: TextStyle(color: Colors.grey))
           ],
         ),
         ),
         Padding(
           padding:EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
           child: Text('Leatherby Libraries'),
         ),
         Padding(
           padding:EdgeInsets.only(left: 8.0, top: 4.0, bottom: 8.0),
           child: Text('Host: Wilkinson College'),
         ),
          Padding(
           padding:EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
           child: Text('About', style: TextStyle(fontSize:16)),
         ),
         Padding(
           padding:EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
           child: Text(myEvent.description, textAlign: TextAlign.left, style: TextStyle(color:Colors.grey)),
         ),
         Padding(
           padding:EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
           child: Text('Accessibility'),
         ),
          Padding(
           padding:EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
          child: Text('Note: this person did not idicate if this event was accessible for the sight impaired or the hearing impaired.', style: TextStyle(color:myColor)),
         ),
        ],
        )
        )
        
      )
       
    );
  }
}
