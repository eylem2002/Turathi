import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//page to view all comments on selected place
class CommentsPlace extends StatefulWidget {
  final PlaceModel place;

  const CommentsPlace({super.key, required this.place});

  @override
  State<CommentsPlace> createState() => _CommentsPlaceState();
}

class _CommentsPlaceState extends State<CommentsPlace> {
  final TextEditingController _commentController = TextEditingController();
  bool isTextFieldEnabled = true;

  CommentList? commentList;

  @override
  Widget build(BuildContext context) {
    CommentProvider provider = Provider.of<CommentProvider>(context);

    return Scaffold(
      appBar: AppBar(

        title: Text(
          'Comments for ${widget.place.title}',
          style: ThemeManager.textStyle.copyWith(
            color: ThemeManager.primary,
            fontWeight: FontWeight.w800,
            fontFamily: ThemeManager.fontFamily,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
          Padding(
            padding:
                EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.04),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: LayoutManager.widthNHeight0(context, 1) * 0.005,
                        color: ThemeManager.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(
                      LayoutManager.widthNHeight0(context, 1) * 0.01),
                  child: Column(
                    children: [
                      TextField(
                        controller: _commentController,
                        enabled: isTextFieldEnabled,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        maxLength: 140,
                        style: TextStyle(
                          height:
                              LayoutManager.widthNHeight0(context, 1) * 0.01,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          counterText: '',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                LayoutManager.widthNHeight0(context, 1) * 0.65),
                        child: defaultButton(
                          text: 'Send',
                          borderRadius: 18,
                          background: ThemeManager.primary,
                          textColor: ThemeManager.second,
                          onPressed: () {
                              setState(() {
                                provider
                                    .addComment(CommentModel(
                                        commentTxt: _commentController.text,
                                        placeId: widget.place.placeId))
                                    .whenComplete(() =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Comment Added"))));

                                _commentController.clear();
                              });
                          },
                          borderWidth: 23,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: provider.getPlaceComments(widget.place.placeId!),
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
                    child: Padding(
                        padding: EdgeInsets.all(
                            LayoutManager.widthNHeight0(context, 1) * 0.05),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return CommentCard(
                                commentModel: commentList!.comments[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Divider(height: 1, color: Colors.grey[300]),
                            itemCount: commentList!.comments.length)),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(
                      top: LayoutManager.widthNHeight0(context, 1) * 0.35),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "No Comments On This Place Yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeManager.primary,
                            fontFamily: ThemeManager.fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                LayoutManager.widthNHeight0(context, 0) * 0.021,
                          ),
                        ),
                        SizedBox(
                            height:
                                LayoutManager.widthNHeight0(context, 0) * 0.01),
                        Text(
                          "You're welcome to share your\n thoughts and comments!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: ThemeManager.fontFamily,
                            fontSize:
                                LayoutManager.widthNHeight0(context, 0) * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
