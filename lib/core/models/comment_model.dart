import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/utils/shared.dart';

// Model class representing a comment
class CommentModel { 
  String? id; // Unique identifier for the comment
  DateTime? date; // Timestamp of when the comment was created
  String? commentTxt; // The text of the comment
  String? writerName;// the creator of the comment
  int? writtenByExpert; // to check of this comment written by expert or not 
  String? placeId; // Identifier for the place
  String? questionId;// Identifier for the question

  CommentModel(
      {
        required this.commentTxt,
        this.placeId,
        this.questionId}){
          id=uuid.v4();
          date = DateTime.now();
          writerName = sharedUser.name;
          writtenByExpert = sharedUser.role == UsersRole.expert.name ? 1 : 0;

  }

   //This is a factory Constructor to create CommentModel instance from JSON obj
  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date =  (json["date"] as Timestamp).toDate();
    commentTxt = json['commentTxt'];
    writerName = json['writerName'];
    writtenByExpert = json['writtenByExpert'];
    placeId = json['placeId'];
    questionId = json['questionId'];
  }

//convert the CommentModel instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['commentTxt'] = this.commentTxt;
    data['writerName'] = this.writerName;
    data['writtenByExpert'] = this.writtenByExpert;
    data['placeId'] = this.placeId;
    data['questionId'] = this.questionId;
    return data;
  }
}


//  class representing a list of comments
class CommentList {
  List<CommentModel> comments;

  CommentList({required this.comments});

  factory CommentList.fromJson(List<dynamic> data) {

    List<CommentModel> temp = [];
    temp = data.map((item) {
      return CommentModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return CommentList(comments: temp);
  }
}
