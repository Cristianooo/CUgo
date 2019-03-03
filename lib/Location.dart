
import 'package:cloud_firestore/cloud_firestore.dart';

class Location{
  const Location({this.title, this.geopoint});

  final String title;
  final GeoPoint geopoint;
}

