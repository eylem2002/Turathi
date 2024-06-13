import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_layer.dart';

// Service class To Manage Reports in Database
class ReportService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "reports";

  // add report about place to database
  Future<String> addReport(ReportModel model) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "report added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

}

