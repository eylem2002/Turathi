import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/utils/shared.dart';

// Model class representing a NotificationModel
class NotificationModel {
  String? id;
  String? userId;
  String? text;
  DateTime? date;
  bool? isRead;

  NotificationModel({ required this.userId, required this.text}){
    id = uuid.v4();
    date = DateTime.now();
    isRead = false;
  }

//This is a factory Constructor to create NotificationModel instance from JSON obj
  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    text = json['text'];
    date = (json["date"] as Timestamp).toDate();
    isRead = json['isRead'];

  }


//convert the NotificationModel instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['date'] = this.date;
    data['isRead'] = this.isRead;

    return data;
  }
}


//  class representing a list of Notifications
class NotificationList {
  List<NotificationModel> notifications;

  NotificationList({required this.notifications});

  factory NotificationList.fromJson(List<dynamic> data) {

    List<NotificationModel> temp = [];
    temp = data.map((item) {
      return NotificationModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return NotificationList(notifications: temp);
  }
}
