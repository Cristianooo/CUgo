import 'package:flutter/material.dart';
import 'UI/my_flutter_app_icons.dart';

class FirstTab extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _FirstTabState();

}

class _FirstTabState extends State<FirstTab> {


  @override
  Widget build(BuildContext context) {
      return new ListView(
        children: <Widget>[
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('Italian club meeting'),
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Group photography'),
            ),
            ListTile(
              leading: Icon(MyFlutterApp.football),
              title: Text('Pickup football'),
            ),
          ],
      );
    }
}