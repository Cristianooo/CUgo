import 'package:flutter/material.dart';
import 'package:cugo_project/ReportExplanation.dart';

class IncorrectDetails extends StatelessWidget {



  @override
  Widget build(BuildContext context) {


  void _openResponse(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ReportExplanation(title: title)));
  }
    return new Scaffold(
      appBar: AppBar(
        
      ),
      body: Container(
        margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(top: 20, bottom: 20),
                child: Text('Something wrong?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Text('Issue with the event', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ),
               Container(
                  decoration: BoxDecoration(
                   border: new Border(top: BorderSide(width: 1.0, color: Colors.grey), bottom: BorderSide(width:1.0, color: Colors.grey))
                 ),
                 child: FlatButton(
                    child: SizedBox(
                    width: double.infinity,
                    child: Text('Info is incorrect', style: TextStyle(fontSize: 18),textAlign: TextAlign.left),
                    ),
                    onPressed:(){
                      _openResponse('Incorrect Info');
                    } 
                   )
               ),
              Container(
                  decoration: BoxDecoration(
                   border: new Border(bottom: BorderSide(width:1.0, color: Colors.grey))
                 ),
                 child: FlatButton(
                    child: SizedBox(
                    width: double.infinity,
                    child: Text('Content is hateful or abusive', style: TextStyle(fontSize: 18),textAlign: TextAlign.left),
                    ),
                    onPressed: (){
                      _openResponse('Hateful Content');
                    }
                   )
               ),
               Container(
                  decoration: BoxDecoration(
                   border: new Border(bottom: BorderSide(width:1.0, color: Colors.grey))
                 ),
                 child: FlatButton(
                    child: SizedBox(
                    width: double.infinity,
                    child: Text('Content is inappropriate', style: TextStyle(fontSize: 18),textAlign: TextAlign.left),
                    ),
                    onPressed:(){
                       _openResponse('Inappropriate Content');
                    }
                   )
               ),
              Container(
                  decoration: BoxDecoration(
                   border: new Border(bottom: BorderSide(width:1.0, color: Colors.grey))
                 ),
                 child: FlatButton(
                    child: SizedBox(
                    width: double.infinity,
                    child: Text('Event is unsafe', style: TextStyle(fontSize: 18),textAlign: TextAlign.left),
                    ),
                    onPressed: () {
                      _openResponse('Unsafe Event');
                    } 
                   )
               ),
               Padding(
                padding: EdgeInsets.only(top: 24, bottom: 16),
                child: Text('Issue with the app', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                   Container(
                  decoration: BoxDecoration(
                   border: new Border(top: BorderSide(width: 1.0, color: Colors.grey), bottom: BorderSide(width:1.0, color: Colors.grey))
                 ),
                 child: FlatButton(
                    child: SizedBox(
                    width: double.infinity,
                    child: Text('App feedback', style: TextStyle(fontSize: 18),textAlign: TextAlign.left),
                    ),
                    onPressed: (){
                      _openResponse('App feedback');
                    }
                   )
                  )
                 ],
               )
          ],
          ),
        
          
        
      ),
      
    );

  }
}
