
import 'dart:developer';

import 'package:geocode/geocode.dart';
// return user current city based on his location
Future<String> UserCity(
    {required double latitude, required double longitude}) async {
  String t = "NULL";
try{

  // using GeoCode Package
  await GeoCode()
      .reverseGeocoding(latitude: latitude, longitude: longitude)
      .then((value) {
    t = value.city ?? "***";
  });
}catch(Exception){
  t = "Waiting";
  log(Exception.toString()+"#########");
}
  return t;
}
