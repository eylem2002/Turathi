import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_layer.dart';

// Service class To Manage Comments in Database
class CommentService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "comments";

  // add comment to database
  Future<String> addComment(CommentModel model) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "comment added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  // get comments for specific place based on placeId
  Future<CommentList> getPlaceComments(String placeId) async {
    QuerySnapshot commentsData =
    await _fireStore.collection(_collectionName)
        .where('placeId', isEqualTo: placeId)
        .get()
        .whenComplete(() {
log("Place comments done");
    }).catchError((error) {
      log(error.toString());
    });
    return _getComments(commentsData);

  }

  // get comments for specific question based on questionId
  Future<CommentList> getQuestionComments(String questionId) async {
    QuerySnapshot commentsData =
    await _fireStore.collection(_collectionName)
        .where('questionId', isEqualTo: questionId)
        .get()
        .whenComplete(() {
    }).catchError((error) {
      log(error.toString());
    });

    return _getComments(commentsData);
  }

  Future<CommentList> _getComments(QuerySnapshot commentsData) async{
    Map<String, dynamic> data = {};
    CommentModel tempModel;
    CommentList commentList = CommentList(comments: []);

    for (var item in commentsData.docs) {
      data["id"] = item.get("id");
      data["date"] = item.get("date");
      data["commentTxt"] = item.get("commentTxt");
      data["writerName"] = item.get("writerName");
      data["writtenByExpert"] = item.get("writtenByExpert");
      data["placeId"] = item.get("placeId");
      data["questionId"] = item.get("questionId");
      tempModel = CommentModel.fromJson(data);

      commentList.comments.add(tempModel);
    }
    return commentList;
  }
}

