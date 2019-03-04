import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Location.dart';


//Use this class later

class EventCard extends StatelessWidget {

  EventCard({this.name, this.date, this.location });

  final String name;
  final DateTime date;
  var cardDateFormat = new DateFormat("EEEE  MMMM d, y");
  final location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.mood),
            title: Text("imgay"),
            subtitle: Text("This is a chicken wing"),
          )
        ],
      )
    );

  }
  
}