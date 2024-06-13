import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import '../../../view_layer.dart';

// A stateless widget representing a dialog for writing comments
class CommentDialog extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final String questionId;

  CommentDialog({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    String writeAComment = "Write a comment";
    String hintPart = 'Share your ideas here...';
    String cancel = 'Cancel';
    String errorMsg = "Please write a comment before saving";
    String save = 'Save';

    CommentProvider provider = Provider.of<CommentProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Container(
        color: ThemeManager.second,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              writeAComment,
              style: ThemeManager.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              controller: commentController,
              decoration: InputDecoration(
                hintText: hintPart,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary)),
              ),
            ),
            const SizedBox(height: 20),
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
                  onPressed: () {
                    if (commentController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return showCustomAlertDialog(context, errorMsg);
                        },
                      );
                    } else {
                      log(commentController.text);
                      provider
                          .addComment(CommentModel(
                              commentTxt: commentController.text,
                              questionId: questionId))
                          .whenComplete(() => Navigator.of(context).pop());
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
    );
  }
}
