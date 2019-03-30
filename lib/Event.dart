import 'package:cloud_firestore/cloud_firestore.dart';
class Event {
  String description;
  String name;
  Timestamp date;
  String location;
  String documentID; 
  Event(this.name, this.description, this.date, this.location, this.documentID);

  
}