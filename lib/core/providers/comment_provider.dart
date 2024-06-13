import 'package:flutter/cupertino.dart';
import '../data_layer.dart';

// Provider class To Manage comments
class CommentProvider extends ChangeNotifier {
  final CommentService _commentService = CommentService();

  // add a new comment
  Future<String> addComment(CommentModel model) async {
    String msg = (await _commentService.addComment(model).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

  //  get comments associated with a specific question
  Future<CommentList> getQuestionComments(String questionId) async {
    return await _commentService.getQuestionComments(questionId);
  }

  // get comments associated with a specific question
  Future<CommentList> getPlaceComments(String placeId) async {
    return await _commentService.getPlaceComments(placeId);
  }
}