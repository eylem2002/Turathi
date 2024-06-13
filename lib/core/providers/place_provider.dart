import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data_layer.dart';

// Provider class To Manage Places
class PlaceProvider extends ChangeNotifier {
  final PlaceService _placeService = PlaceService();

  PlaceList _placeList = PlaceList(places: []);

  //Getter for Places List
  Future<PlaceList> get placeList async {
    if (_placeList.places.isEmpty) {
      await _getPlaces();
    }
    return _placeList;
  }

  // add new place
  Future<String> addPlace(
      {required PlaceModel model, required List<XFile> images}) async {
    // check if the place is exist before adding it
    bool exists = await _placeService.placeExists(model.title.toString());

    if (exists) {
      log("Place with title ${model.title} already exists");
      return "Place already exists";
    }

    _placeList.places.add(await _placeService
        .addPlace(model: model, images: images)
        .whenComplete(() async {
      log("Add place successfully");
      notifyListeners();
    }));

    return "Done";
  }

  Future<void> _getPlaces() async {
    _placeList = await _placeService.getPlaces().whenComplete(() {
      log("Provider get places");
    });
  }
// update place data && images
  Future<PlaceModel> updatePlace(
      {required PlaceModel placeModel, required List<XFile> images}) async {
    log(placeModel.toJson().toString());
    int index = _placeList.places.indexOf(placeModel);
    _placeList.places[index] = await _placeService
        .updatePlace(placeModel: placeModel, images: images)
        .whenComplete(() {
      notifyListeners();
      log("update place list");
    });
    return placeModel;
  }

  // add like to specific place
  Future<PlaceModel> likePlace(String id) async {
    var index =
        _placeList.places.indexWhere((element) => element.placeId == id);
    PlaceModel temp = await _placeService.likePlace(
        id, _placeList.places[index].likesList!.length);
    _placeList.places[index] = temp;
    await getMostPopularPlaces();
    notifyListeners();
    return temp;
  }

  // delete the like that added to specific place
  Future<PlaceModel> deletePlaceLike(String id) async {
    var index =
        _placeList.places.indexWhere((element) => element.placeId == id);

    PlaceModel temp = await _placeService.disLikePlace(
        id, _placeList.places[index].likesList!.length);
    _placeList.places[index] = temp;

    await getMostPopularPlaces();
    notifyListeners();
    return temp;
  }

  // get the nearest place by (specific value) kilometers based on specific latitude ,longitude
  Future<PlaceList> getNearestPlaceList(
      selectedNearestLat, selectedNearestLog, distanceValue) async {
    List<PlaceModel> nearestPlaces = [];
    PlaceList places = _placeList;

    nearestPlaces = places.places.where((place) {
      double distanceInKm = getDistanceInKm(
        lat1: place.latitude!,
        lon1: place.longitude!,
        lat2: selectedNearestLat,
        lon2: selectedNearestLog,
      );
      log(distanceInKm.toString());
      return distanceInKm <= distanceValue;
    }).toList();

    return PlaceList(places: nearestPlaces);
  }

  // get 10 places with highest likes
  Future<PlaceList> getMostPopularPlaces() async {
    PlaceList places = await placeList;
    if (places.places.isNotEmpty) {
      if (places.places.length >= 10) {
        return PlaceList(places: places.places.getRange(0, 9).toList());
      }
      log(places.places.getRange(0, places.places.length).first.title! +
          "{{{{");

      return places;
    }
    return PlaceList(places: []);
  }

  // change the selected nearest place latitude and longitude
  updatePosition(lat, long) {
    selectedNearestLat = lat;
    selectedNearestLog = long;
    notifyListeners();
  }

  // delete place data and images
  deletePlace(PlaceModel place_model) {
    _placeList.places.remove(place_model);
    _placeService.deletePlace(placeModel: place_model).whenComplete(() {
      notifyListeners();
    });
  }

  //test this function
  PlaceList getFavPlaces(places) {
    List<PlaceModel> tempList = [];

    for (String id in sharedUser.favList!) {
      PlaceModel tempModel = places.firstWhere(
          (element) => element.placeId == id,
          orElse: () => PlaceModel.empty());
      if (tempModel.placeId != "-1" || tempModel.isVisible == false) {
        tempList.add(tempModel);
      }
    }
    return PlaceList(places: tempList);
  }
}
