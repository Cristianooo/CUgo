import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CalendarQuery extends StatefulWidget {
  const CalendarQuery({this.date});
  final DateTime date;


  @override
  State<StatefulWidget> createState() => new _CalendarQuery();

}

class _CalendarQuery extends State<CalendarQuery> {
  @override
  void initState() {
    dateBeg = DateTime(widget.date.year, widget.date.month, widget.date.day - 1,
        11, 59, 59, 59);
    dateEnd = DateTime(
        widget.date.year, widget.date.month, widget.date.day, 11, 59, 59, 59);
    super.initState();
    print(dateBeg);
    print(dateEnd);
  }

  void reset(DateTime resetDate){
    setState(() {
    dateBeg = DateTime(resetDate.year, resetDate.month, resetDate.day - 1,
        11, 59, 59, 59);
    dateEnd = DateTime(
        resetDate.year, resetDate.month, resetDate.day, 11, 59, 59, 59);
    });
  }
  DateTime dateBeg;
  DateTime dateEnd;
  @override
  Widget build(BuildContext context) {
    var eventTimeFormat = new DateFormat("jm");
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('events')
            .orderBy('date')
            .where('date', isGreaterThanOrEqualTo: dateBeg)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new Container(
                  child: ListView(
                padding: EdgeInsets.all(16.0),
                shrinkWrap: true,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return 
                  Card(//CHANGE HEIGHT OF LIST THING
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
        });
  }
}
