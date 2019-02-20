import 'package:cloud_firestore/cloud_firestore.dart';
class Event {
  String description;
  String name;
  Timestamp date;
  GeoPoint location;
  Event(this.name, this.description, this.date, this.location);

  
}