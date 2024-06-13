import 'dart:developer';

import 'package:turathi/core/models/comment_model.dart';

import '../../utils/shared.dart';

enum PlaceState { NewPlace, TrustWorthy, RegularPlace }

// Model class representing a PlaceModel
class PlaceModel {
  String? userId;
  String? placeId;
  String? title;
  String? description;
  String? status;
  String? address;
  String? state;
  List<String>? images;
  List<String>? likesList;
  int? like;

  bool? isVisible;
  double? longitude;
  double? latitude;

  PlaceModel.empty() {
    placeId = '-1';
  }

  PlaceModel(
      {required this.title,
      required this.description,
      required this.address,
      required this.longitude,
      required this.latitude,
      this.status,
      this.likesList}) {
    placeId = uuid.v4();
    userId = sharedUser.id;
    status = "Open To Visit";
    state = PlaceState.NewPlace.name;
    likesList = [];
    like = 0;
    isVisible = true;
  }

//This is a factory Constructor to create PlaceModel instance from JSON obj
  PlaceModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    placeId = json['placeId'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    address = json['address'];
    state = json['state'];
    like = json['like'];
    likesList = json['likesList'].cast<String>();
    isVisible = json['isVisible'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

//convert the PlaceModel instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['placeId'] = this.placeId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['address'] = this.address;
    data['state'] = this.state;
    data['like'] = this.like;
    data['likesList'] = this.likesList;
    data['isVisible'] = this.isVisible;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}


//  class representing a list of Places
class PlaceList {
  List<PlaceModel> places;

  PlaceList({required this.places});

  factory PlaceList.fromJson(List<dynamic> data) {
    log("I'm In Place List Factory");
    //1. temp list
    List<PlaceModel> tempPlaces = [];
    tempPlaces = data.map((item) {
      return PlaceModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return PlaceList(places: tempPlaces);
  }
}
