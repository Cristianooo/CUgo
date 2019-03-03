import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Location.dart';

class CreateEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CreateEvent();
}

class _CreateEvent extends State<CreateEvent> {

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

 @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
      return new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Container(
                color: Colors.blueAccent,
                height:50,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding:EdgeInsets.only(left:8.0),
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: new Text('Cancel',
                            style: new TextStyle(color: Colors.white))),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(right:8.0),
                      child: new GestureDetector(
                      onTap: () {
                        _addEvent();
                        Navigator.pop(context);
                      },
                      child: new Text('Create Event', 
                      style: new TextStyle(color: Colors.white)),
                    ),
                    ),
                  ],
                ),
              ),
              new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new ListTile(
                      leading: Text('Name of Event'),
                      title: new TextFormField(
                        controller: nameController,
                        validator: (value) => value.isEmpty ? 'Event name can\'t be empty' : null,
                      ),
                    ),
                    new ListTile(
                      leading: Text('Description of Event'),
                      title: new TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: descController,
                        validator: (value) => value.isEmpty ? 'Event description can\'t be empty' : null,
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
    }
}
