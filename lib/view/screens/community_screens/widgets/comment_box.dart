import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';

import '../../../view_layer.dart';

//widget represents comments on the app
class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.comment});

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {

    String role = "EXPERT"; // Define role label for experts
   String imageUrlUserProfile='assets/images/img_png/userProfile.png'; // Path to user profile image asset

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display differently if the comment is written by an expert
            comment.writtenByExpert == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            imageUrlUserProfile,
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.05,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.05,
                          ),
                          Text(
                            comment.writerName!,
                            style: TextStyle(
                              fontFamily: ThemeManager.fontFamily,
                              color: ThemeManager.primary,
                            ),
                          )
                        ],
                      ),
                      Text(
                        role,
                        style: TextStyle(
                            color: ThemeManager.primary,
                            backgroundColor:
                                ThemeManager.primary.withOpacity(0.1)),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        imageUrlUserProfile,
                        width: LayoutManager.widthNHeight0(context, 0) * 0.05,
                        height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                      ),
                      Text(
                        comment.writerName!,
                        style: TextStyle(
                          fontFamily: ThemeManager.fontFamily,
                          color: ThemeManager.primary,
                        ),
                      )
                    ],
                  ),
            const SizedBox(
              height: 5,
            ),
            Text(comment.commentTxt!)
          ],
        ),
      ),
    );
  }
}
