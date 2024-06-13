import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../data_layer.dart';

// Provider class To Manage Notifications
class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  NotificationList _notificationList = NotificationList(notifications: []);

  //Getter for Notifications List for current user
  Future<NotificationList> get notificationList async {
    if (_notificationList.notifications.isEmpty) {
      await _getNotifications();
    }
    return _notificationList;
  }

  // get the Notifications from NotificationService
  Future<void> _getNotifications() async {
    _notificationList =
        await _notificationService.getUserNotifications().whenComplete(() {
      log("Provider get notifications");
    });
  }

  Future<void> updateUserNotifications() async {
    await _notificationService.updateUserNotifications().whenComplete(() {
      for (var i = 0; i < _notificationList.notifications.length; i++) {
        _notificationList.notifications[i].isRead = true;
      }
      notifyListeners();
    });
  }
}
