import 'package:flutter/material.dart';
import 'auth.dart';
import 'Choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firstTab.dart' as first;
import 'secondTab.dart' as second;
import 'thirdTab.dart' as third;

import 'ProfilePage.dart';


const List<Choice> choices = const <Choice>[
  const Choice(title: 'Events', icon: Icons.calendar_view_day),
  const Choice(title: 'Calendar', icon: Icons.event),
  const Choice(title: 'Map', icon: Icons.map),
];
String userUID;
  void findCorrectDB() async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userUID = user.uid;
    
  }

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        appBar: new AppBar(
          leading: new Padding(
            padding:EdgeInsets.only(left:8.0),
            child: FlatButton(
            child: Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              findCorrectDB();
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(auth: auth, onSignedOut: onSignedOut, userUID: userUID,)),
              );}
          ),
          ),
          
          title: new Padding(
              child: new Text("CU Go"),
              padding: const EdgeInsets.only(left: 20.0)),
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


