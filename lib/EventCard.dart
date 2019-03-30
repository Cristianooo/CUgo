import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


//Use this class later

class EventCard extends StatelessWidget {

  EventCard({this.name, this.date, this.location });

  final String name;
  final DateTime date;
  final cardDateFormat = new DateFormat("EEEE  MMMM d, y");
  final location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.mood),
            title: Text("ll"),
            subtitle: Text("This is a chicken wing"),
          )
        ],
      )
    );

  }
  
}