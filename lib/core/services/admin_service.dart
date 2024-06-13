import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import '../data_layer.dart';

// Service class To Manage Admin operations
class AdminService {
  // collection names
  final String _collectionName = "admins";
  final String _reportCollectionName = "reports";
  final String _requestCollectionName = "requests";
  final String _placeCollectionName = "places";
  final String _userCollectionName = "users";

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FilesStorageService _filesStorageService = FilesStorageService();

  // List of placeIds that have a report.
  final Set<String> _placesIds = <String>{};
  Set<String> get placesIds => _placesIds;

  //sign in for admin using adminId and password
  Future<bool> signIn(String adminId, String password) async {
    // get admin model from firebase store
    AdminModel? adminModel = await _getAdmin(adminId);

    if (adminModel != null && adminModel.password != null) {
      String? passwordFromDb = adminModel.password;
      //check if the password is correct
      // by hashing it and compare with the store password
      if (Crypt(passwordFromDb!).match(password)) {
        return true;
      }
    }
    return false;
  }

  // get all places
  Future<PlaceList> getPlaces() async {
    QuerySnapshot placesData = await _fireStore
        .collection(_placeCollectionName)
        .get()
        .whenComplete(() {
      log("getPlaces done");
    }).catchError((error) {
      log(error.toString());
    });

    PlaceModel tempModel;
    PlaceList placeList = PlaceList(places: []);
    for (var item in placesData.docs) {
      tempModel = PlaceModel.fromJson(item.data() as Map<String, dynamic>);
      tempModel.images = await _filesStorageService.getImages(
          imageType: ImageType.placesImages.name,
          folderName: tempModel.placeId!);

      placeList.places.add(tempModel);
    }
    return placeList;
  }

  //get all reports
  Future<ReportList> getReports() async {
    QuerySnapshot reportsData = await _fireStore
        .collection(_reportCollectionName)
        .get()
        .whenComplete(() {
      log("get reports done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    ReportModel tempModel;
    ReportList reportList = ReportList(reports: []);
    for (var item in reportsData.docs) {
      data["reportId"] = item.get("reportId");
      data["reasons"] = item.get("reasons");
      data["userId"] = item.get("userId");
      data["placeId"] = item.get("placeId");

      // add the place id of the report to _placesIds list
      _placesIds.add(data["placeId"]);
      tempModel = ReportModel.fromJson(data);

      reportList.reports.add(tempModel);
    }
    return reportList;
  }

  // get all users requests to be an expert
  Future<RequestList> getRequests() async {
    QuerySnapshot requestsData = await _fireStore
        .collection(_requestCollectionName)
        .get()
        .whenComplete(() {
      log("get requests done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    RequestModel tempModel;
    RequestList requestList = RequestList(requests: []);
    for (var item in requestsData.docs) {
      data["requestId"] = item.get("requestId");
      data["status"] = item.get("status");
      data["certificate"] = item.get("certificate");
      data["userId"] = item.get("userId");
      tempModel = RequestModel.fromJson(data);
      requestList.requests.add(tempModel);
    }
    return requestList;
  }

// accept or reject the user request to be an expert
  Future<void> updateRequestStatus(
      {required RequestModel requestModel,
      required RequestStatus requestStatus}) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_requestCollectionName)
        .where('requestId', isEqualTo: requestModel.requestId)
        .get();
    String id = requestData.docs[0].id;
    _fireStore
        .collection(_requestCollectionName)
        .doc(id)
        // update the request status
        .update({'status': requestStatus.name}).whenComplete(() {
      // if admin accept the request , the user will be updated to expert
      if (requestStatus.name == RequestStatus.accepted.name) {
        updateUserRoleToExpert(id: requestModel.userId!);
      }
      // if admin reject the request , the request will be deleted from database
      else if (requestStatus.name == RequestStatus.rejected.name) {
        deleteRequest(requestModel: requestModel);
      }
      // else the user will be notified with his request status (data warning,,,,)
      else {
        notifyUser(requestModel.userId!,
            "your request status is ${requestStatus.name}");
      }
      log("update request status done");
    }).catchError((error) {
      log(error.toString());
    });
  }

  // delete the request from database
  Future<void> deleteRequest({required RequestModel requestModel}) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_requestCollectionName)
        .where('requestId', isEqualTo: requestModel.requestId)
        .get();
    String id = requestData.docs[0].id;
    _fireStore
        .collection(_requestCollectionName)
        .doc(id)
        .delete()
        .whenComplete(() {
          // delete the pdf file for the deleted request
      _filesStorageService.deleteFile(userId: requestModel.userId!);
      // notify user
      notifyUser(requestModel.userId!, "your request to be expert is rejected");
      log("delete request done");
    }).catchError((error) {
      log(error.toString());
    });
  }
// update user role to expert in database
  Future<void> updateUserRoleToExpert({required String id}) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_userCollectionName)
        .where('id', isEqualTo: id)
        .get();
    String userId = requestData.docs[0].id;
    _fireStore
        .collection(_userCollectionName)
        .doc(userId)
        .update({'role': UsersRole.expert.name}).whenComplete(() {
          // notify user
      notifyUser(id, "your role is expert");
      log("update user role done");
    }).catchError((error) {
      log(error.toString());
    });
  }
// update place data in database
  Future<void> updatePlace({required PlaceModel placeModel}) async {
    log(placeModel.toJson().toString());
    QuerySnapshot placesData = await _fireStore
        .collection(_placeCollectionName)
        .where('placeId', isEqualTo: placeModel.placeId)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref

    _fireStore
        .collection(_placeCollectionName)
        .doc(placeId)
        .update(placeModel.toJson())
        .whenComplete(() {
      log("UPDATE done");
    }).catchError((error) {
      log(error.toString());
    });
  }

  // change the place visibility
  Future<void> updatePlaceVisibility(
      {required String placeId, required bool isVisible}) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_placeCollectionName)
        .where('placeId', isEqualTo: placeId)
        .get();
    String id = placesData.docs[0].id; //id for the ref

    _fireStore
        .collection(_placeCollectionName)
        .doc(id)
        .update({"isVisible": isVisible}).whenComplete(() {
      log("update isVisible to ${isVisible.toString()} done");
    }).catchError((error) {
      log(error.toString());
    });
  }

  // when admin change the place visibility ,the related reports will be deleted
  Future<void> deleteReports(List<ReportModel> reports) async {
    for (ReportModel mode in reports) {
      QuerySnapshot requestData = await _fireStore
          .collection(_reportCollectionName)
          .where('reportId', isEqualTo: mode.reportId)
          .get();
      String id = requestData.docs[0].id;
      _fireStore.collection(_reportCollectionName).doc(id).delete();
    }
  }

  // send notifications for user
  Future<void> notifyUser(String userId, String text) async {
    NotificationModel notificationModel =
        NotificationModel(userId: userId, text: text);
    _fireStore
        .collection("notifications")
        .add(notificationModel.toJson())
        .whenComplete(() {
      log("Add Notification to ${userId} Done");
    });
  }

  Future<AdminModel?> _getAdmin(String adminId) async {
    QuerySnapshot adminData = await _fireStore
        .collection(_collectionName)
        .where('adminId', isEqualTo: adminId)
        .get();
    if (adminData.docs.isEmpty) {
      return null;
    }

    Map<String, dynamic> data = {};
    data["adminId"] = adminData.docs[0].get("adminId");
    data["password"] = adminData.docs[0].get("password");
    return AdminModel.fromJson(data);
  }

  Map<String, dynamic> dataList = {};
  ReportList reportList = ReportList(reports: []);
}
