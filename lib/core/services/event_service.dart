import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../data_layer.dart';

// Service class To Manage Events in Database
class EventService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "events";
  final FilesStorageService _filesStorageService = FilesStorageService();

  // add event to database
  Future<EventModel> addEvent(EventModel model, List<XFile> images) async {
    model.images = await _filesStorageService
    // upload event images to storage
        .uploadImages(
            imageType: ImageType.eventImages.name, // Event image
            folderName: model.id!, // Event Id
            pickedImages: images!)
        .whenComplete(() {
      _fireStore
          .collection(_collectionName)
          .add(model.toJson())
          .whenComplete(() => log("Event Done -------------------------"));
    }).catchError((error) {
      log(error.toString());
    });
    return model;
  }

  // Get the two newest events
  Future<EventList> get twoEventsList async {
    QuerySnapshot eventsData = await _fireStore
        .collection(_collectionName)
        .where("date", isGreaterThan: DateTime.now()) // based on the date
        .limit(2) // only get two
        .get();
    EventModel tempModel;
    EventList eventList = EventList(events: []);
    for (var item in eventsData.docs) {
      tempModel = EventModel.fromJson(item.data() as Map<String, dynamic>);

      tempModel.images = await _filesStorageService.getImages(
          imageType: ImageType.eventImages.name, folderName: tempModel.id!);

      eventList.events.add(tempModel);
    }
    log(eventList.events.length.toString());

    return eventList;
  }

  // get all events from database
  Future<EventList> getEvents() async {
    QuerySnapshot eventsData = await _fireStore
        .collection(_collectionName)
        .where("date", isGreaterThan: DateTime.now())
        .get()
        .whenComplete(() {
      log("get events done");
    }).catchError((error) {
      log(error.toString());
    });
    EventModel tempModel;
    EventList eventList = EventList(events: []);
    for (var item in eventsData.docs) {
      tempModel = EventModel.fromJson(item.data() as Map<String, dynamic>);

      // get the images urls and assign it to images list in event model
      tempModel.images = await _filesStorageService.getImages(
          imageType: ImageType.eventImages.name, folderName: tempModel.id!);
      eventList.events.add(tempModel);
    }

    return eventList;
  }

  // update event data
  Future<EventModel> updateEvent(
      {required EventModel eventModel, List<XFile>? images}) async {
    QuerySnapshot eventsData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: eventModel.id)
        .get();
    String eventId = eventsData.docs[0].id;
    log(images.toString());
    // if the images list is not null ,add the images to storage
    if (images != null) {
      eventModel.images!.addAll(await _filesStorageService.uploadImages(
          imageType: ImageType.eventImages.name,
          folderName: eventModel.id!,
          pickedImages: images!));
    }
    _fireStore
        .collection(_collectionName)
        .doc(eventId)
        .update(eventModel.toJson())
        .whenComplete(() {
      log("UPDATE done");
    }).catchError((error) {
      log(error.toString());
    });
    return eventModel;
  }
}
