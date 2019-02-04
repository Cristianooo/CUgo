import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Location.dart';

class FirstTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  static Location af = new Location(
      title: 'Agyros Forum', geopoint: GeoPoint(33.792995, -117.850680));
  static Location lib = new Location(
      title: 'Leatherby Libraries', geopoint: GeoPoint(33.792895, -117.851275));
  final _chapLocations = [af, lib];
  String _currentItemSelected;
  GeoPoint _tempLocation;

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final locationController = TextEditingController();

  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(new Duration(days: 1)),
      lastDate: DateTime.now().add(new Duration(days: 365)),
    );

    if (picked != null && picked != _date) {
      print("Date selected: ${_date.toString()}");
      setState(() {
        _date = picked;
      });
    }
  }

  void _addEvent() {
    for (Location myGeo in _chapLocations) {
      if (_currentItemSelected == myGeo.title) {
        _tempLocation = myGeo.geopoint;
      }
    }
    Firestore.instance.collection('events').document().setData({
      'name': nameController.text,
      'description': descController.text,
      'date': _date,
      'location': _tempLocation,
    });
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Column(
            children: <Widget>[
              new Container(
                color: Colors.blueAccent,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: new Text('Cancel',
                            style: new TextStyle(color: Colors.white))),
                    new Center(
                      child: Text('Create an Event',
                          style: new TextStyle(color: Colors.white)),
                    ),
                    new RaisedButton(
                      child: Text('Create Event'),
                      onPressed: _addEvent,
                    )
                  ],
                ),
              ),
              new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new ListTile(
                      leading: Text('Name of Event'),
                      title: new TextField(
                        controller: nameController,
                      ),
                    ),
                    new ListTile(
                      leading: Text('Description of Event'),
                      title: new TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: descController,
                      ),
                    ),
                    new ListTile(
                        leading: Text('Date of Event'),
                        trailing: new RaisedButton(
                          child: Text('Pick a date'),
                          onPressed: () {
                            _selectDate(context);
                          },
                        )),
                    new ListTile(
                      leading: Text('Location of Event'),
                      trailing: new DropdownButton<String>(
                        items: _chapLocations.map((Location myLocation) {
                          return DropdownMenuItem<String>(
                            value: myLocation.title,
                            child: Text(myLocation.title),
                          );
                        }).toList(),
                        hint: Text('Select Item'),
                        onChanged: (String newSelect) {
                          setState(() {
                            _currentItemSelected = newSelect;
                          });
                        },
                        value: _currentItemSelected,
                      ),
                    ),
                  ]),
            ],
          );
        });
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
