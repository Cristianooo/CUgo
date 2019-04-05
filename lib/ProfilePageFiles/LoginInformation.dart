import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
 

 class LoginInformation extends StatefulWidget {
   LoginInformation({this.userToken});
   final String userToken;
  @override
    State<StatefulWidget> createState() => new LoginInformationState();
 }

 class LoginInformationState extends State<LoginInformation> {
  final newPassword = TextEditingController();
  String _newPassword;
  String _confirmPassword;

  @override
    Widget build(BuildContext context) {
      
      return Scaffold(
          appBar: new AppBar(
            title: new Padding(
                child: new Text("Login Information"),
                padding: const EdgeInsets.only(left: 20.0)),
          ),
          body: new Container(
            margin:EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
               _buildForm()

              ],
            )
          )
      );
    }

    Widget _passwordField() {
    return new TextFormField(
      controller: newPassword,
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(labelText: 'Change Password'),
        validator: (value) =>
          value.isEmpty ? "Password can't be empty" : null,
        onSaved: (val) => _newPassword = val
    );
  }

  Widget _passwordConfirmField() {
    return new TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(labelText: 'Confirm New Password'),
        validator: (value) {
           if(value != newPassword.text){
             return 'Passwords must match';
           }
        },
       
        onSaved: (val) => _confirmPassword = val
    );
  }
  final formKey = new GlobalKey<FormState>();
  Widget _buildForm() {
     return new Form(
      autovalidate: true, 
      key: formKey, 
      child: new Column(children: <Widget>[
         _passwordField(),
         _passwordConfirmField(),
         new RaisedButton(
            child: Text('Change Password'),
            onPressed: () => submit()
         )
      ]
      )
     );

      }

void submit() {
   final form = formKey.currentState;

   if (form.validate()) {
      form.save();  
      changePassword(_newPassword);
   } 

}
Future<Null> changePassword(String newPassword) async {
  const String API_KEY = 'AIzaSyByzoreP8QjUrEC-caFvMVMW-MuvoAXk9g';
  final String changePasswordUrl =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=$API_KEY';

    final Map<String, dynamic> payload = {
      'email': widget.userToken,
      'password': newPassword,
      'returnSecureToken': true
    };

  await http.post(changePasswordUrl, 
    body: json.encode(payload), 
    headers: {'Content-Type': 'application/json'},  
  );
}
 }