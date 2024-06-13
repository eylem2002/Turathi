import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    Key? key,
    this.width = 300,
    this.aspectRatio = 0.7,
    required this.onPress,
    required this.placeModel,
  }) : super(key: key);

  final double width, aspectRatio;
  final PlaceModel placeModel;
  final VoidCallback onPress;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    // isFavourite = widget.placeModel.isFavourite!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      widget.placeModel.images != null &&
                              widget.placeModel.images!.isNotEmpty
                          ? widget.placeModel.images![0]
                          : 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.15),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
                Positioned(
                  bottom: LayoutManager.widthNHeight0(context, 0) * 0.055,
                  left: LayoutManager.widthNHeight0(context, 0) * 0.014,
                  child: Text(
                    widget.placeModel.title != null
                        ? widget.placeModel.title!.toUpperCase()
                        : 'No Title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(3, 3),
                        ),
                      ],
                      color: ThemeManager.second,
                      fontFamily: ThemeManager.fontFamily,
                      fontWeight: FontWeight.w900,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.017,
                    ),
                  ),
                ),
                if (AdminCheck == false)
                    Positioned(
                      bottom: LayoutManager.widthNHeight0(context, 0) * 0.02,
                      right: LayoutManager.widthNHeight0(context, 1) * 0.025,
                      child: Icon(
                        sharedUser.favList != null &&
                                widget.placeModel.placeId != null &&
                                sharedUser.favList!
                                    .contains(widget.placeModel.placeId!)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: ThemeManager.primary,
                      ),
                    ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
