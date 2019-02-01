import 'package:flutter/material.dart';
import 'auth.dart';
import 'root_page.dart';

void main() => runApp(FirstScreen());

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CUgo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: new RootPage(auth: new Auth())
    );

   /* return new Scaffold( 
          appBar: AppBar(
            title: Text('CU Go'),
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("Cristiano Firmani"),
                  accountEmail: new Text("firma103@mail.chapman.edu"),
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text("CF"),
                  ),
                ),
                new Divider(),
                new ListTile(
                  title: new Text("Calendar"),
                  trailing: new Icon(Icons.event_note)
                ),
                new ListTile(
                  title: new Text("Events"),
                  trailing: new Icon(Icons.calendar_view_day)
                ),
              ],
            ),
      )
    );*/
  }
}
