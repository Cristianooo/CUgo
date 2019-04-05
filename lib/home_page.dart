import 'package:flutter/material.dart';
import 'auth.dart';
import 'Choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'firstTab.dart' as first;
import 'secondTab.dart' as second;
import 'thirdTab.dart' as third;

import 'ProfilePageFiles/ProfilePage.dart';


const List<Choice> choices = const <Choice>[
  const Choice(title: 'Events', icon: FontAwesomeIcons.bars),
  const Choice(title: 'Calendar', icon: FontAwesomeIcons.calendarAlt),
  const Choice(title: 'Map', icon: FontAwesomeIcons.globeAmericas),
  
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
  
    void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => findCorrectDB());
  }

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
          bottom: new TabBar(
            tabs: choices.map((Choice choice) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )
                ),
                child: Tab(
                text: choice.title,
                icon: Icon(choice.icon),
                
                )
              );
              
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            new first.FirstTab(userUID),
            new second.SecondTab(),
            new third.ThirdTab(),
          ]
        ),
      ),
    );
  }
}


