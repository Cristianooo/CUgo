import 'package:cloud_firestore/cloud_firestore.dart';
class Event {
  String description;
  String name;
  Timestamp date;
  String location;
  String documentID; 
  String createdBy;
  bool wheelchairAccess;
  bool seeingAccess;
  bool hearingAccess;
  Event({this.name, this.description, 
  this.date, this.location, 
  this.documentID, this.createdBy, 
  this.wheelchairAccess, this.seeingAccess,
  this.hearingAccess});

  
}