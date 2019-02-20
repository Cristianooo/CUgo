import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
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

    /*
      final int numWeekdays = 7;
      var size = MediaQuery.of(context).size;

      final double itemHeight = (size.height - kToolbarHeight-24-28-55) / 6;
      final double itemWidth = size.width / numWeekdays;

      return new FutureBuilder(
        future: _getCalendarData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return new LinearProgressIndicator();
            case ConnectionState.done:
              return new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          'S', textAlign: TextAlign.center,
                          style: Theme 
                                  .of(context) 
                                  .textTheme 
                                  .headline)),
                      new Expanded(
                        child: new Text(
                          'M', textAlign: TextAlign.center,
                          style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline)),
                      new Expanded(
                        child: new Text(
                          'T', textAlign: TextAlign.center,
                          style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline)),
                      new Expanded(
                        child: new Text(
                          'W', textAlign: TextAlign.center,
                          style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline)),
                      new Expanded(
                        child: new Text(
                          'Th', textAlign: TextAlign.center,
                          style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline)),
                      new Expanded(
                        child: new Text(
                          'F', textAlign: TextAlign.center,
                          style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline)),
                      new Expanded(
                        child: new Text(
                          'Sa', textAlign: TextAlign.center,
                          style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline)),
                  
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  new GridView.count(
                    crossAxisCount: numWeekdays,
                  )
                ]
            )
          }
        }

      )
        
  }
}
*/