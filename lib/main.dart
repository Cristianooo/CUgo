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

  }
}
