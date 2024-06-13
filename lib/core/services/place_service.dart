import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../data_layer.dart';

// Service class To Manage Places in Database
class PlaceService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "places";
  final FilesStorageService _filesStorageService = FilesStorageService();
  final NotificationService _notificationService = NotificationService();

  // ad place to database
  Future<PlaceModel> addPlace(
      {required PlaceModel model, required List<XFile> images}) async {
    // upload the images to FirebaseStorage
    model.images = await _filesStorageService
        .uploadImages(
            imageType: ImageType.placesImages.name,
            folderName: model.placeId!,
            pickedImages: images!)
        .whenComplete(() {
      _fireStore
          .collection(_collectionName)
          .add(model.toJson())
          .whenComplete(() {
        _notificationService.notifyUsers(model.latitude!, model.longitude!,model.title!);
        log("Add Place Done");
      });
    });

    return model;
  }

  //check if the place is exist before adding new one
  Future<bool> placeExists(String title) async {
    final querySnapshot = await _fireStore
        .collection(_collectionName)
        .where('title', isEqualTo: title)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // get places from database
  Future<PlaceList> getPlaces() async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('isVisible', isEqualTo: true) // return only the visible places
        .orderBy('like', descending: true) // order the list by the number of likes
        .get()
        .whenComplete(() {
      log("getPlaces done");
    }).catchError((error) {
      log(error.toString());
    });
    //map to store docs data in
    Map<String, dynamic> data = {};
    //temp model
    PlaceModel tempModel;
    //temp list
    PlaceList placeList = PlaceList(places: []);
    for (var item in placesData.docs) {
      data["placeId"] = item.get("placeId");
      data["userId"] = item.get("userId");
      data["state"] = item.get("state");
      data["address"] = item.get("address");
      data["status"] = item.get("status");
      data["description"] = item.get("description");
      data["title"] = item.get("title");
      data["latitude"] = item.get("latitude");
      data["longitude"] = item.get("longitude");
      data["isVisible"] = item.get("isVisible");
      data["like"] = item.get("like");
      data["likesList"] = item.get("likesList");
      tempModel = PlaceModel.fromJson(data);
      // get the images from FirebaseStorage and assign them to the images list
      tempModel.images = await _filesStorageService.getImages(
          imageType: ImageType.placesImages.name,
          folderName: tempModel.placeId!);

      placeList.places.add(tempModel);
    }
    return placeList;
  }

  // update place data in database
  Future<PlaceModel> updatePlace(
      {required PlaceModel placeModel, required List<XFile> images}) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('placeId', isEqualTo: placeModel.placeId)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref
    log(images.toString());
    if (images.isNotEmpty) {
      placeModel.images!.addAll(await _filesStorageService.uploadImages(
          imageType: ImageType.placesImages.name,
          folderName: placeModel.placeId!,
          pickedImages: images));
    }
    _fireStore
        .collection(_collectionName)
        .doc(placeId)
        .update(placeModel.toJson())
        .whenComplete(() {
      log("UPDATE done");
    }).catchError((error) {
      log(error.toString());
    });
    return placeModel;
  }

  // delete the place from database
  Future<void> deletePlace({required PlaceModel placeModel}) async {
    try {
      QuerySnapshot placesData = await FirebaseFirestore.instance
          .collection(_collectionName)
          .where('placeId', isEqualTo: placeModel.placeId)
          .get();
      String placeId = placesData.docs[0].id;

      await FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(placeId)
          .delete()
          .whenComplete(() async {
            // delete the place images from FirebaseStorage
        await _filesStorageService.deleteImages(
            imageType: ImageType.placesImages.name,
            folderName: placeModel.placeId!);
      });

      log("Place deleted successfully");
    } catch (error) {
      log("Error deleting place: $error");
      throw error;
    }
  }

  // get the place by its id
  Future<PlaceModel> getPlaceById(String id) async {
    QuerySnapshot placeData = await _fireStore
        .collection(_collectionName)
        .where('placeId', isEqualTo: id)
        .get();
    Map<String, dynamic> data = {};

    PlaceModel tempModel;
    data["placeId"] = placeData.docs[0].get("placeId");
    data["userId"] = placeData.docs[0].get("userId");
    data["state"] = placeData.docs[0].get("state");
    data["address"] = placeData.docs[0].get("address");
    data["status"] = placeData.docs[0].get("status");
    data["description"] = placeData.docs[0].get("description");
    data["title"] = placeData.docs[0].get("title");
    data["latitude"] = placeData.docs[0].get("latitude");
    data["longitude"] = placeData.docs[0].get("longitude");
    data["isVisible"] = placeData.docs[0].get("isVisible");
    data["like"] = placeData.docs[0].get("like");
    data["likesList"] = placeData.docs[0].get("likesList");

    tempModel = PlaceModel.fromJson(data);
    // get the images from FirebaseStorage and assign them to the images list

    tempModel.images = tempModel.images = await _filesStorageService.getImages(
        imageType: ImageType.placesImages.name, folderName: tempModel.placeId!);

    return tempModel;
  }

  // add like to place
  Future<PlaceModel> likePlace(String id, int likes) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('placeId', isEqualTo: id)
        .get();
    String placeId = placesData.docs[0].id;

    try {
      await FirebaseFirestore.instance.collection('places').doc(placeId).update(
        {
          'likesList': FieldValue.arrayUnion([sharedUser.id]), // add the user id to the likesList
          'like': likes + 1, // increment the likes number by one
          // change the place state to TrustWorthy if the number of likes greater than  or equal 5
          if (placesData.docs[0].get("like") >= 5)
            'state': PlaceState.TrustWorthy.name
        },
      ).whenComplete(() {
        log("LIKE PLACE : ${placeId}");
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
    return await getPlaceById(id);
  }

  // remove like from place
  Future<PlaceModel> disLikePlace(String id, int likes) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('placeId', isEqualTo: id)
        .get();
    String placeId = placesData.docs[0].id;
    try {
      await FirebaseFirestore.instance.collection('places').doc(placeId).update(
        {
          'likesList': FieldValue.arrayRemove([sharedUser.id]), // remove the user id from the likesList
          'like': likes - 1, // decrement the likes number by one
          // change the place state to RegularPlace if the number of likes greater than  or equal 5
          if (placesData.docs[0].get("like") < 5)
            'state': PlaceState.RegularPlace.name
        },
      ).whenComplete(() {
        log("disLikePlace : ${placeId}");
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
    return await getPlaceById(id);
  }
}
