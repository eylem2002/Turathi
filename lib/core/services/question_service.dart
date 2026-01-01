import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../data_layer.dart';

// Service class To Manage Questions in Database
class QuestionService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "questions";
  final FilesStorageService _filesStorageService = FilesStorageService();

  // add question to database
  Future<QuestionModel> addQuestion(
      QuestionModel model, List<XFile> images) async {
    // upload the images to FirebaseStorage
    model.images = await _filesStorageService
        .uploadImages(
            imageType: ImageType.questionImages.name,
            folderName: model.id!,
            pickedImages: images!)
        .whenComplete(() {
      _fireStore
          .collection(_collectionName)
          .add(model.toJson())
          .whenComplete(() {
            log("question added successfully");;
      });
    });

    return model;
  }
// get questions from database
  Future<QuestionList> getQuestions() async {
    QuerySnapshot questionsData =
        await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("questions done");
    }).catchError((error) {
      log(error.toString());
    });
    QuestionList questionList = QuestionList(questions: []);
    final fetchedQuestions =
        await Future.wait(questionsData.docs.map((item) async {
      final data = item.data() as Map<String, dynamic>;
      var images = (data["images"] as List?)?.cast<String>() ?? [];
      if (images.isEmpty) {
        images = await _filesStorageService.getImages(
            imageType: ImageType.questionImages.name,
            folderName: data["id"] ?? '');
        item.reference.update({"images": images});
      }
      data["images"] = images;
      return QuestionModel.fromJson(data);
    }));
    questionList.questions.addAll(fetchedQuestions);

    return questionList;
  }
}
