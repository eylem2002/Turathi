import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_layer.dart';

// Service class To Manage User Request in Database

class RequestService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "requests";
  final FilesStorageService _filesStorageService = FilesStorageService();

  // add request to be an expert to database
  Future<String> addRequest(RequestModel model, File file) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() async {
          // upload the pdf file and get the url value
      model.certificate = await _filesStorageService.addFile(file);
      // update the certificate url
      updateRequestFiled(
          id: model.requestId!,
          filedName: "certificate",
          value: model.certificate!);
    }).catchError((error) {
      return "Failed";
    });
    return "Done";
  }

  // get request for the current user
  Future<RequestModel> getRequestByUserId() async {
    QuerySnapshot requestData = await _fireStore
        .collection(_collectionName)
        .where('userId', isEqualTo: sharedUser.id)
        .get();
    RequestModel tempModel = RequestModel.empty();

    if (requestData.docs.isNotEmpty) {
      Map<String, dynamic> data = {};
      data["requestId"] = requestData.docs[0].get("requestId");
      data["userId"] = requestData.docs[0].get("userId");
      data["certificate"] = requestData.docs[0].get("certificate");
      data["status"] = requestData.docs[0].get("status");

      tempModel = RequestModel.fromJson(data);
    }
    return tempModel;
  }

  // update request data in database
  Future<void> updateRequestFiled(
      {required String filedName,
      required String value,
      required String id}) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_collectionName)
        .where('requestId', isEqualTo: id)
        .get();
    String requestId = requestData.docs[0].id;
    _fireStore
        .collection(_collectionName)
        .doc(requestId)
        .update({filedName: value}).whenComplete(() {
      log("update request done");
    }).catchError((error) {
      log(error.toString());
    });
  }
}
