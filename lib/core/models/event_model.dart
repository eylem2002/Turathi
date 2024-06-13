import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/utils/shared.dart';

// Model class representing a EventModel
class EventModel {
  String? id;
  String? name;
  DateTime? date;
  String? description;
  String? address;
  double? longitude;
  double? latitude;
  double? ticketPrice;
  String? creatorName;
  List<String>? images;

  EventModel(
      {
      required this.name,
        required this.date,
        required this.description,
        required this.address,
        required this.longitude,
        required this.latitude,
        this.ticketPrice = 0,
      }){
    id= uuid.v4();
    creatorName = sharedUser.name;


  }
//This is a factory Constructor to create EventModel instance from JSON obj
  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = (json["date"] as Timestamp).toDate();

    description = json['description'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    ticketPrice = json['ticketPrice'];
    creatorName = json['creatorName'];

  }

//convert the EventModel instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['description'] = this.description;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['ticketPrice'] = this.ticketPrice;
    data['creatorName'] = this.creatorName;

    return data;
  }
}

//  class representing a list of Events
class EventList {
  List<EventModel> events;

  EventList({required this.events});

  factory EventList.fromJson(List<dynamic> data) {

    List<EventModel> temp = [];
    temp = data.map((item) {
      return EventModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return EventList(events: temp);
  }
}
