import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//a page to view selected question and it's all comments
class QuestionView extends StatefulWidget {
  const QuestionView({super.key, required this.question});

  final QuestionModel question;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  CommentList? commentList;
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    String noCommentsCase= "No Comments On This Place Yet";
    String noCommentsCase2= "You're welcome to share your\n thoughts and comments!"; 
    var height = LayoutManager.widthNHeight0(context, 0) * 0.4;
    CommentProvider provider = Provider.of<CommentProvider>(context);

    double left = 15;
    double iconLeft = 10;
    return Stack(
      children: <Widget>[
        SizedBox(
          height: height + 170,
          width: double.infinity,
          child: Image.network(
            color: Colors.black.withOpacity(0.2),
            colorBlendMode: BlendMode.darken,
            widget.question.images![selectedImage],
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: LayoutManager.widthNHeight0(context, 1) * 0.18, //45,
          right: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int index = 0;
                  index < widget.question.images!.length;
                  index++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SmallImage(
                    isSelected: index == selectedImage,
                    press: () {
                      setState(() {
                        selectedImage = index;
                      });
                    },
                    image: widget.question.images![index],
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          top: height - 25,
          left: left,
          child: Text(
            widget.question.writerName!,
            style: TextStyle(
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 1,
                    offset: Offset(3, 2),
                  ),
                ],
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.second,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.02,
                decoration: TextDecoration.none),
          ),
        ),
        Positioned(
          top: height - LayoutManager.widthNHeight0(context, 0) * 0.0001,
          left: left - 5,
          child: Text(
            widget.question.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: ThemeManager.fontFamily,
              fontSize: LayoutManager.widthNHeight0(context, 0) * 0.026,
              fontWeight: FontWeight.w600,
              color: ThemeManager.second,
              decoration: TextDecoration.none,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 2,
                  offset: Offset(3, 2),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: height + 50,
            bottom: 0,
            child: Container(
              height: LayoutManager.widthNHeight0(context, 0),
              width: LayoutManager.widthNHeight0(context, 1),
              decoration: BoxDecoration(
                  color: ThemeManager.second,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      widget.question.questionTxt!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          wordSpacing: 1,
                          fontFamily: ThemeManager.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          color: ThemeManager.textColor,
                          decoration: TextDecoration.none),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Divider(color: Colors.grey[300]),
                    ),
                    FutureBuilder(
                        future:
                            provider.getQuestionComments(widget.question.id!),
                        builder: (context, snapshot) {
                          var data = snapshot.data;
                          if (data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          commentList = data;
                          if (commentList!.comments.isNotEmpty) {
                            return Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return CommentCard(
                                        commentModel:
                                            commentList!.comments[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                            height: 1, color: Colors.grey[300]),
                                    itemCount: commentList!.comments.length));
                          }
                          return Padding(
                            padding: EdgeInsets.only(
                                top: LayoutManager.widthNHeight0(context, 1) *
                                    0.1),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    DefaultTextStyle(
                                      style: TextStyle(),
                                      child: Text(
                                       noCommentsCase,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ThemeManager.primary,
                                          fontFamily: ThemeManager.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          fontSize: LayoutManager.widthNHeight0(
                                                  context, 0) *
                                              0.021,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: LayoutManager.widthNHeight0(
                                                context, 0) *
                                            0.01),
                                    DefaultTextStyle(
                                      style: TextStyle(),
                                      child: Text(
                                       noCommentsCase2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: ThemeManager.fontFamily,
                                          color: ThemeManager.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: LayoutManager.widthNHeight0(
                                                  context, 0) *
                                              0.02,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 40,
          right: 20,
          child: AddButton(onPressed: () {
            //controller //BACK
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CommentDialog(
                  questionId: widget.question.id!,
                );
              },
            );
          }),
        ),
        Positioned(
          top: 40,
          left: iconLeft,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
