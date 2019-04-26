import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SecondTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();

  DateTime dateBeg;
  DateTime dateEnd;


  QuerySnapshot _allEventSnapshot;
  String _currentMonth = '';
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      FontAwesomeIcons.calendarDay,
      color: Colors.amber,
    ),
  );

  Future<QuerySnapshot> _getCalendarData() async {
    QuerySnapshot allEvents =
        await Firestore.instance.collection('events').getDocuments();

    _allEventSnapshot = allEvents;
    return _allEventSnapshot;
  }

  EventList<Event> _markedDateMap = new EventList<Event>(events: {}
      );

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  void initState() {
    dateBeg = DateTime(_currentDate2.year, _currentDate2.month, _currentDate2.day - 1,
        11, 59, 59, 59);
    dateEnd = DateTime(
        _currentDate2.year, _currentDate2.month, _currentDate2.day, 11, 59, 59, 59);

    _markedDateMap.add(
        new DateTime(2019, 2, 25),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.blue[100],
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() => _currentDate2 = date);
        setState(() {
          _currentDate2 = date;
          dateBeg = DateTime(_currentDate2.year, _currentDate2.month, _currentDate2.day - 1,
          11, 59, 59, 59);
          dateEnd = DateTime(
          _currentDate2.year, _currentDate2.month, _currentDate2.day, 11, 59, 59, 59);
        });
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      selectedDayButtonColor: Colors.blue[100],
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      markedDateMoreShowTotal:
          false, // null for not showing hidden events indicator
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(
        color: Colors.blue[300],
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 1000)),
      maxSelectedDate: _currentDate.add(Duration(days: 1000)),
//      inactiveDateColor: Colors.black12,
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );
    var eventTimeFormat = new DateFormat("jm");
    return new Container(
        child: Stack(
      children: <Widget>[
        FutureBuilder(
            future: _getCalendarData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                //watch the FUCK OUT return new LinearProgressIndicator();
                case ConnectionState.done:
                  return new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //custom icon
                      //custom icon without header
                      Container(
                        margin: EdgeInsets.only(
                          top: 30.0,
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              _currentMonth,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            )),
                            FlatButton(
                              child: Text('PREV'),
                              onPressed: () {
                                setState(() {
                                  _currentDate2 = _currentDate2
                                      .subtract(Duration(days: 30));
                                  _currentMonth =
                                      DateFormat.yMMM().format(_currentDate2);
                                });
                              },
                            ),
                            FlatButton(
                              child: Text('NEXT'),
                              onPressed: () {
                                setState(() {
                                  _currentDate2 =
                                      _currentDate2.add(Duration(days: 30));
                                  _currentMonth =
                                      DateFormat.yMMM().format(_currentDate2);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: _calendarCarouselNoHeader,
                      )

                      //We have to change the widget to understand that a new date has been selected. This is done with the setState() method.
                    ],
                  );
                  break;
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return new Text('Result: ${snapshot.data}');
              }
            }),
        Positioned(
            top: MediaQuery.of(context).size.height / 2.2,
            child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('events')
                        .orderBy('date')
                        .where('date', isGreaterThanOrEqualTo: dateBeg)
                        .where('date', isLessThanOrEqualTo: dateEnd)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          if(snapshot.data.documents.length == 0){
                            return new Text('No events for this date.');
                          }
                          return new Container(
                              child: ListView(
                            padding: EdgeInsets.all(16.0),
                            shrinkWrap: true,
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return Card(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: new Text(document['name']),
                                      subtitle: new Text(eventTimeFormat
                                          .format(document['date'].toDate())),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ));
                      }
                    })))
      ],
    ));
  }
}
