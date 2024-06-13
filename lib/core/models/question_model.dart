import 'package:turathi/utils/shared.dart';


// Model class representing a QuestionModel
class QuestionModel {
  String? id;
  List<String>? images;
  String? title;
  String? questionTxt;
  String? writerName;

  QuestionModel(
      {  required this.title, required this.questionTxt}){
    id=uuid.v4();
    writerName = sharedUser.name;

  }

//This is a factory Constructor to create QuestionModel instance from JSON obj
  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    title = json['title'];
    questionTxt = json['questionTxt'];
    writerName = json['writer'];
  }

//convert the QuestionModel instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['title'] = this.title;
    data['questionTxt'] = this.questionTxt;
    data['writer'] = this.writerName;
    return data;
  }
}

//  class representing a list of Questions
class QuestionList {
  List<QuestionModel> questions;

  QuestionList({required this.questions});

  factory QuestionList.fromJson(List<dynamic> data) {

    List<QuestionModel> temp = [];
    temp = data.map((item) {
      return QuestionModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return QuestionList(questions: temp);
  }
}
