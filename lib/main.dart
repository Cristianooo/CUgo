import 'package:flutter/material.dart';
import 'auth.dart';
import 'root_page.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';

void main() => runApp(FirstScreen());

class FirstScreen extends StatelessWidget {
 static final Map<int, Color> color =
{
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
};
  final MaterialColor colorCustom = MaterialColor(0xFFA50034, color);
  
  @override
  Widget build(BuildContext context) {
    FlutterUxcam.startWithKey("6hv4utoek4hyaw4");
    return new MaterialApp(
      title: 'CUgo',
      theme: new ThemeData(
        primarySwatch: colorCustom

      ),
      home: new RootPage(auth: new Auth())
    );

  }
}
