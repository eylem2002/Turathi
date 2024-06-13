import 'package:flutter/material.dart';

import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';
class LikeButton extends StatefulWidget {
  final PlaceModel placeModel;
  final Function onLike;

  LikeButton({required this.placeModel, required this.onLike});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() { // Call the onLike function when the button is pressed
          widget.onLike();
        });
      },
      icon: SizedBox(
        width: LayoutManager.widthNHeight0(context, 1) * 0.045,
        height: LayoutManager.widthNHeight0(context, 1) * 0.045,
        child: Image.asset(

           // Show filled like icon if the current user has liked the place
          widget.placeModel.likesList!.contains(sharedUser.id)
              ? "assets/images/img_png/like_filled.png"
              : "assets/images/img_png/like.png",
          color: ThemeManager.primary,
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}