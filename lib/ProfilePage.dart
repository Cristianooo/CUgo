import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ProfileFiles/PersonalInformation.dart';
import 'ProfileFiles/LoginInformation.dart';

import 'auth.dart';

class ProfilePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userUID;

  const ProfilePage({this.auth, this.onSignedOut, this.userUID});

  @override
  State<StatefulWidget> createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

 Color lightGrey= const Color(0xffba0006);
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: new AppBar(
          title: new Padding(
              child: new Text("Profile Page"),
              padding: const EdgeInsets.only(left: 20.0)),
        ),
        body: new Container(
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  child: new PhysicalModel(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.circular(100.0),
                      child: Icon(FontAwesomeIcons.kiwiBird, size: 50)),
                ),
                new StreamBuilder(
                    stream: Firestore.instance
                        .collection('Users')
                        .where('UID', isEqualTo: widget.userUID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Text('Loading data. Please wait...');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Text(
                                        snapshot.data.documents[0]
                                            ['First Name'],
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                  Text(snapshot.data.documents[0]['Last Name'],
                                      style: TextStyle(fontSize: 20)),
                                ]),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                                snapshot.data.documents[0]['Grade Level'],
                                style: TextStyle(fontSize: 20)),
                          ),
                          new Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Column(
                                    children: <Widget>[
                                      Text(
                                          (snapshot.data.documents[0]
                                                  ['EventAmt'])
                                              .toString(),
                                          style: TextStyle(fontSize: 40)),
                                      Text('Events Attended',
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                  new Column(
                                    children: <Widget>[
                                      Text(
                                          (snapshot.data.documents[0]
                                                  ['PointsAmt'])
                                              .toString(),
                                          style: TextStyle(fontSize: 40)),
                                      Text('Points Achieved',
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  )
                                ],
                              ))
                        ],
                      );
                    }),
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  children: <Widget>[
                    const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                    RaisedButton(
                      child: new Align(
                         alignment: Alignment.centerLeft,
                         child: Text('Login Information', style: TextStyle(color: Colors.black)),
                      ),
                      onPressed: _changeLoginInformation,
                    ),
                    RaisedButton(
                      child:  new Align(
                         alignment: Alignment.centerLeft,
                         child: Text('Personal Information', style: TextStyle(color: Colors.black))
                      ),
                      onPressed: _changePersonalInfo,
                    ),
                  ],
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: new RaisedButton(
                      child: Text('Sign out'),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          _signOut();
                        });
                      }),
                )
              ],
            )));
  }
  void _changeLoginInformation(){
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginInformation()),
              );
  }
  void _changePersonalInfo() {
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInformation()),
              );
  }
}