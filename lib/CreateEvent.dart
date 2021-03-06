import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Location.dart';
import 'dart:async';

class CreateEvent extends StatefulWidget {
  const CreateEvent(this.uid);
  final String uid;


  @override
  State<StatefulWidget> createState() => new _CreateEvent();
}

class _CreateEvent extends State<CreateEvent> {
  bool _wheelchairAccess = false;
  bool _seeingImpairedAccess = false;
  bool _hearingImpairedAccess = false;

  static Location af = new Location(
      title: 'Argyros Forum', geopoint: GeoPoint(33.792995, -117.850680));
  static Location lib = new Location(
      title: 'Leatherby Libraries', geopoint: GeoPoint(33.792895, -117.851275));
  static Location stadium = new Location(
      title: 'Ernie Chapman Stadium',
      geopoint: GeoPoint(33.794054, -117.850903));
  static Location memorialLawn = new Location(
      title: 'Memorial Lawn', geopoint: GeoPoint(33.791995, -117.852535));
  static Location memorialHall = new Location(
      title: 'Memorial Hall', geopoint: GeoPoint(33.792895, -117.851275));
  static Location fish = new Location(
      title: 'FISH Interfaith Center',
      geopoint: GeoPoint(33.793709, -117.852212));
  static Location piazza = new Location(
      title: 'Atallah Piazza', geopoint: GeoPoint(33.793061, -117.851753));
  static Location irvineHall = new Location(
      title: 'Irvine Lecture Hall', geopoint: GeoPoint(33.792280, -117.850732));
  static Location musco = new Location(
      title: 'Musco Center for the Arts',
      geopoint: GeoPoint(33.794164, -117.852634));
  static Location sandhu = new Location(
      title: 'Sandhu Conference Center',
      geopoint: GeoPoint(33.794164, -117.852634)); //Fix location
    
  final _chapLocations = [
    af,
    lib,
    stadium,
    memorialLawn,
    memorialHall,
    fish,
    piazza,
    irvineHall,
    musco, 
    sandhu
  ];
  String _currentItemSelected;

  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  DateTime _date = new DateTime.now();
  String _dateText = "";
  var eventDayFormat = new DateFormat("EEEE  MMMM d, y");

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(new Duration(days: 1)),
      lastDate: DateTime.now().add(new Duration(days: 365)),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _dateText = eventDayFormat.format(_date);
      });
    }
  }

  TimeOfDay _time = new TimeOfDay.now();
  String _timeText = "";
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null) {
      setState(() {
        _time = picked;
        _timeText = todString(_time);
      });
    }
  }

  String todString(TimeOfDay time) {
    int hourConvert = time.hour;
    String ampm = "AM";
    if (time.hour > 12) {
      ampm = "PM";
      hourConvert -= 12;
    }

    final String hourLabel = hourConvert.toString();
    String minuteLabel = '';
    if (time.minute < 10) {
      minuteLabel = "0" + time.minute.toString();
    } else {
      minuteLabel = time.minute.toString();
    }

    return '$hourLabel:$minuteLabel $ampm';
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

  void _addEvent() {
    DateTime _finalDate = new DateTime(
        _date.year, _date.month, _date.day, _time.hour, _time.minute);
      String imgay = monthAndDay(_finalDate);

    Firestore.instance.collection('events').document().setData({
      'name': _nameController.text,
      'description': _descController.text,
      'date': _finalDate,
      'monthDay': imgay,
      'location': _currentItemSelected,
      'wheelchairAccess': _wheelchairAccess,
      'seeingAccess': _seeingImpairedAccess,
      'hearingAccess': _hearingImpairedAccess,
      'createdBy': widget.uid
    });
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          actions: <Widget>[
            new FlatButton(
              child: new Text("Create Event",
                  style: TextStyle(color: Colors.white)),
              onPressed: _addEvent,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    child: Text('Name of Event',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    padding: EdgeInsets.only(top: 40))),
            TextFormField(
              controller: _nameController,
              validator: (value) =>
                  value.isEmpty ? 'Event name can\'t be empty' : null,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    child: Text('Description of Event',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    padding: EdgeInsets.only(top: 20))),
            TextFormField(
              controller: _descController,
              validator: (value) =>
                  value.isEmpty ? 'Event description can\'t be empty' : null,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        child: Text('Date of Event',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.only(top: 20))),
                Column(
                  children: <Widget>[
                  new RaisedButton(
                    child: Text('Pick a date'),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                  new Text(_dateText)
                ]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        child: Text('Time of Event',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.only(top: 20))),
                Column(
                  children: <Widget>[
                  new RaisedButton(
                    child: Text('Pick a time'),
                    onPressed: () {
                      _selectTime(context);
                    },
                  ),
                  new Text(_timeText)
                ]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        child: Text('Time of Event',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.only(top: 20))),
                  new DropdownButton<String>(
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
              Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        child: Text('Accessibility',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.only(top: 20)))
                ]),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                                value: _wheelchairAccess,
                                onChanged: (bool value) {
                                  setState(() {
                                    _wheelchairAccess = value;
                                  });
                                },
                              ),
                              Text('Physical accessibility', style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text('The location has wheelchair accessible parking, ramps, elevators, etc.', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                    Row(
                      children: <Widget>[
                        Checkbox(
                                value: _seeingImpairedAccess,
                                onChanged: (bool value) {
                                  setState(() {
                                    _seeingImpairedAccess = value;
                                  });
                                },
                              ),
                              Text('Visual accessibility', style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text('There is adequate lighting, audio information, signage has braille, etc.', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                    Row(
                      children: <Widget>[
                        Checkbox(
                                value: _hearingImpairedAccess,
                                onChanged: (bool value) {
                                  setState(() {
                                    _hearingImpairedAccess = value;
                                  });
                                },
                              ),
                              Text('Auditory accessibility', style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text('The event has accommodations such as ASL translator, subtitles, etc.', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey))
                  ],
                )
          ]),
        ));
  }
}
