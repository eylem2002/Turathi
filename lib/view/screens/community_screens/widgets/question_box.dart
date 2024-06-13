import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';

import '../../../view_layer.dart';

//widget represents QuestionBox on the app
class QuestionBox extends StatelessWidget {
  const QuestionBox({super.key, required this.question});

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    String imageProfile="assets/images/img_png/imageProfile.png";
    String userImage='assets/images/img_png/userProfile.png';
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          questionRoute,
          arguments: question,
        );
      },
      child: Card(
        color: ThemeManager.second,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: question.images != null &&
                            question.images!.isNotEmpty
                        ? Image.network(
                            question.images![0],
                            fit: BoxFit.cover,
                            height:
                                LayoutManager.widthNHeight0(context, 0) * 0.17,
                           
                          )
                        : Image.asset(imageProfile),
                  )),
              SizedBox(
                width: LayoutManager.widthNHeight0(context, 0) * 0.015,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      question.title.toString().toUpperCase(),
                      style: TextStyle(
                        fontFamily: ThemeManager.fontFamily,
                        color: ThemeManager.primary,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            LayoutManager.widthNHeight0(context, 0) * 0.02,
                      ),
                    ),
                     SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.01,
                    ),
                    Text(
                      question.questionTxt!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize:
                            LayoutManager.widthNHeight0(context, 1) * 0.04,
                        fontFamily: ThemeManager.fontFamily,
                        color: ThemeManager.textColor,
                      ),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.07,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            userImage,
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.05,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.05,
                          ),
                          Text(
                            question.writerName!,
                            style: TextStyle(
                              fontFamily: ThemeManager.fontFamily,
                              color: ThemeManager.primary,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
