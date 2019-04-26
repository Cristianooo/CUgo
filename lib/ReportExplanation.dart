import 'package:flutter/material.dart';

class ReportExplanation extends StatelessWidget {
  final String title;
  ReportExplanation({this.title});

  

  @override
  Widget build(BuildContext context) {

    void _submit() {
      Navigator.pop(context);
    }
    
    return new Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text('Let us know more',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
            Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                    'Tell us what\'s wrong and we\'ll be sure to handle it right away!',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.only(bottom: 40.0),
              child: TextField(
                maxLines: 99,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: _submit,
                child: Text('Submit'),
              )   
            )
          ],
        ),
      ),
    );
  }
}
