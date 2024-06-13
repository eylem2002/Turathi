import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../data_layer.dart';

// Provider class To Manage events
class EventProvider extends ChangeNotifier {
  final EventService _eventService = EventService();

  EventList _eventList = EventList(events: []);
  EventList _twoEventsList = EventList(events: []);

  //Getter for Events List
  Future<EventList> get eventList async {
    if (_eventList.events.isEmpty) {
      await _getEvents();
    }
    return _eventList;
  }

  //Getter for newest two Events
  Future<EventList> get twoEventsList async {
    if (_twoEventsList.events.isEmpty) {
      await _getTwoEvents();
    }
    return _twoEventsList;
  }
  // add a new event
  Future<void> addEvent(EventModel model, List<XFile> images) async {
    _eventList.events
        .add(await _eventService.addEvent(model, images).whenComplete(() {
      notifyListeners();
    }));
  }

  //get events from EventService
  Future<void> _getEvents() async {
    _eventList = await _eventService.getEvents();

  }
  Future<void> _getTwoEvents() async {
    _twoEventsList = await _eventService.twoEventsList;

  }

  // update event data && images
  Future<EventModel> updateEvent(
      {required EventModel eventModel, required List<XFile> images}) async {
    log(eventModel.toJson().toString());
    int index = _eventList.events.indexOf(eventModel);
    _eventList.events[index] = await _eventService
        .updateEvent(eventModel: eventModel, images: images)
        .whenComplete(() {
      notifyListeners();
    });
    return eventModel;
  }
}
