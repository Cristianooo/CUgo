import 'package:flutter/material.dart';
 

 class PersonalInformation extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      
      return Scaffold(
          appBar: new AppBar(
            title: new Padding(
                child: new Text("Personal Information"),
                padding: const EdgeInsets.only(left: 20.0)),
          ),
          body: new Container(
            margin:EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Text('Change First Name: ', style: TextStyle(fontSize: 20)),
                new TextFormField(
                 
                )
              ],
            )
          )
      );
    }
 }