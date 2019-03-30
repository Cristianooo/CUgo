import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
  


class SecondTab extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _SecondTabState();

}

class _SecondTabState extends State<SecondTab> {

  DateTime selectedDate = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Calendar(
          isExpandable: true,
          
        
          
          ),
        Text(selectedDate.toString()),
      ],
    );

  }

  
}