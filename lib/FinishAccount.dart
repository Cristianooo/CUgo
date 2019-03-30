
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class FinishAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FinishAccount();
}

class _FinishAccount extends State<FinishAccount> {

  final _gradeLevelOptions = ['Underclassman', 'Upperclassman', 'Master\'s Student'];
  String _currentItemSelected;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  
   void _createUser() async{
     final FirebaseUser user = await FirebaseAuth.instance.currentUser();
     String uid= user.uid;

    Firestore.instance.collection('Users').document().setData({
      'First Name': firstNameController.text,
      'Last Name': lastNameController.text,
      'Grade Level': _currentItemSelected,
      'EventAmt': 0,
      'PointsAmt':0,
      'UID': uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: new AppBar(
       title: new Padding(
              child: new Text("New Account"),
              padding: const EdgeInsets.only(left: 20.0)),
        
     ),
      body: new Padding(
        padding:EdgeInsets.all(8.0),
        child: new Column(
        children: <Widget>[
          new Text('First Name: '),
          new TextFormField(
            controller: firstNameController,
            validator: (value) => value.isEmpty ? 'First name can\'t be empty':null,
          ),
          new Text('Last Name: '),
          new TextFormField(
            controller: lastNameController,
            validator: (value) => value.isEmpty ? 'Last name can\'t be empty':null,
          ),
          new Text('Grade Level: '),
          new DropdownButton<String>(
                        items: _gradeLevelOptions.map((String value) {
                          return DropdownMenuItem<String>( 
                            value: value,
                            child: Text(value), 
                          ); 
                        }).toList(),
                        hint: Text('Select Item'),
                        onChanged: (String newSelect) {
                          setState(() {
                            _currentItemSelected = newSelect;
                          });
                        },
                        value: _currentItemSelected,
                      ),
            new RaisedButton(
              child:Text('Complete Sign Up'),
              onPressed: (){
                _createUser();
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage())
                );
                },
        )
        ],
        
      )

        )
    );
  }
}