import 'package:flutter/material.dart';

class BuddyExplanation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 24),
              child: Text('What is a buddy?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Padding(
              padding:EdgeInsets.only(bottom:20),
              child: Text('The ultimate goal of this app is to promote the comfort and social interaction for all individuals on campus. Many people are more likely to go somewhere if they don’t have to go alone and others enjoy helping people and meeting new friends.', 
              style: TextStyle(fontSize: 16)
              )
            ),
            Padding(
              padding:EdgeInsets.only(bottom:20),
              child: Text('“I want a buddy” \nThis is for people who might feel uncomfortable in social situations. If you aren’t sure what to do at this event or wish you had someone to go with you, we recommend checking this option!',
              style: TextStyle(fontSize: 16)
              )
            ),
            Padding(
              padding:EdgeInsets.only(bottom:20),
              child: Text('“I want to be a buddy.” \nThis is for people who might want to help another person feel more welcome. If you know what to do at the event, enjoy meeting new people, or just want to hang out with someone who might not attend otherwise, we recommend checking this option!',
              style: TextStyle(fontSize: 16),)
            ),

          ],
        ),
      ),
      
    );

  }
}
