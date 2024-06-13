import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import '../../../view_layer.dart';

// A stateless widget representing a dialog for writing Question
class QuestionDialog extends StatefulWidget {
  const QuestionDialog({Key? key}) : super(key: key);

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  final TextEditingController text = TextEditingController();
  final TextEditingController title = TextEditingController();

  List<XFile>? images;

  String txt = '';

  @override
  Widget build(BuildContext context) {
    String writeQuestion='Write a question';
    String hintFiled1='Title';
    String hintField2='Ask your question here...';
    String pickImage= 'Pick Image';
    String cancel='Cancel';
    String errorMsg="*All field are required";
    String save='Save';

    QuestionProvider questionProvider = Provider.of<QuestionProvider>(context);
    return Dialog(
      backgroundColor: ThemeManager.second,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0), // make it circular
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                writeQuestion, // Change text here
                style: ThemeManager.textStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: hintFiled1,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 5,
                controller: text,
                decoration: InputDecoration(
                  hintText: hintField2,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  images = await pickImages();
                },
                style: ThemeManager.buttonStyle,
                child: Text(
                  pickImage,
                  style: ThemeManager.textStyle
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  txt,
                  style: ThemeManager.textStyle.copyWith(
                      fontWeight: FontWeight.w200,
                      color: Colors.red,
                      fontSize: 10),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      cancel,
                      style: ThemeManager.textStyle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {
                      if (text.text.isNotEmpty &&
                          title.text.isNotEmpty &&
                          images != null) {
                        setState(() {
                          txt = "";
                        });
                        await questionProvider
                            .addQuestion(
                                QuestionModel(
                                    title: title.text, questionTxt: text.text),
                                images!)
                            .whenComplete(() => Navigator.of(context).pop());
                      } else {
                        setState(() {
                          txt = errorMsg;
                        });
                        log('add Question failed');
                      }
                    },
                    child: Text(
                      save,
                      style: ThemeManager.textStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
