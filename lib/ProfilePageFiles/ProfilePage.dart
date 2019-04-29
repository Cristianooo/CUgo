import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cugo_project/ProfilePageFiles/LoginInformation.dart';
import 'package:cugo_project/ProfilePageFiles/myEvents.dart';
import 'package:cugo_project/ProfilePageFiles/myPastEvents.dart';

import 'package:cugo_project/auth.dart';

class ProfilePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userUID;

  const ProfilePage({this.auth, this.onSignedOut, this.userUID});

  @override
  State<StatefulWidget> createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

String idToken;           
void findUserIdToken() async{                 //Assigns current user's id token so that the password can be changed in LoginInformation.dart
    var token = await FirebaseAuth.instance.currentUser();
    idToken=token.getIdToken().toString();
  }

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
    return Material(
      child: Column(
        children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFA50034),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200.0),
                    bottomRight: Radius.circular(200.0),
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(FontAwesomeIcons.chevronLeft, size:25, color: Colors.white,),
                      onPressed: (){
                        Navigator.pop(context);
                        },
                    ),
                    Center(
                      child: Container(
                        width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://nexttravelnursing.com/wp-content/uploads/2018/02/Aleesha-Bartlett-Bitmoji.png")
                        )
                      ),
                      )
                    )
                  ],
                )
                ),
                
                
              ),
           Container(
              height: MediaQuery.of(context).size.height *.66,
              width: MediaQuery.of(context).size.width,
            child: new ListView(
              children: <Widget>[
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
                                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                                  ),
                                  Text(snapshot.data.documents[0]['Last Name'],
                                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                                snapshot.data.documents[0]['Grade Level'],
                                style: TextStyle(fontSize: 26)),
                          ),
                          new Padding(
                              padding: EdgeInsets.only(top: 40),
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
                                          style: TextStyle(fontSize: 50)),
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
                                          style: TextStyle(fontSize: 50)),
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
                    RaisedButton(
                      child: new Align(
                         alignment: Alignment.centerLeft,
                         child: Text('My Events', style: TextStyle(color: Colors.black)),
                      ),
                      onPressed: _showEvents,
                      
                    ),
                    RaisedButton(
                      child: new Align(
                         alignment: Alignment.centerLeft,
                         child: Text('My Event History', style: TextStyle(color: Colors.black)),
                      ),
                      onPressed: _showPastEvents,
                      
                    ),
                    const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                    RaisedButton(
                      child: new Align(
                         alignment: Alignment.centerLeft,
                         child: Text('Login Information', style: TextStyle(color: Colors.black)),
                      ),
                      onPressed: _changeLoginInformation,
                    ),
                  ],
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: new RaisedButton(
                      child: Text('Sign out'),
                      color: Colors.red,
                      onPressed: () {
                          _signOut();
                          Navigator.pop(context);

                      }),
                )
              ],
            )),
            
        ],
      )
     );
  }
   void _showEvents(){
    findUserIdToken();
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyEvents(userUID: widget.userUID,)),
            );
  }
  void _showPastEvents(){
    findUserIdToken();
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyPastEvents(userUID: widget.userUID,)),
            );
  }
  
  void _changeLoginInformation(){
    findUserIdToken();
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginInformation(userToken: idToken,)),
            );
  }
}
