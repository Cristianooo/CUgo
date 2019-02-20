import 'package:flutter/material.dart';
import 'auth.dart';
import 'Choice.dart';
import 'firstTab.dart' as first;
import 'secondTab.dart' as second;
import 'thirdTab.dart' as third;

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Events', icon: Icons.calendar_view_day),
  const Choice(title: 'Calendar', icon: Icons.event),
  const Choice(title: 'Map', icon: Icons.map),
];

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Padding(
              child: new Text("CU Go"),
              padding: const EdgeInsets.only(left: 20.0)),
          actions: <Widget>[
            new FlatButton(
              child:
                  new Text("Sign out", style: TextStyle(color: Colors.white)),
              onPressed: _signOut,
            ),
          ],
          bottom: new TabBar(
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            new first.FirstTab(),
            new second.SecondTab(),
            new third.ThirdTab(),

          ]
        ),
      ),
    );
  }
}
