import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

class AddedCard extends StatefulWidget {
  const AddedCard({
    Key? key,
    this.width = 300,
    this.aspectRatio = 0.7,
    required this.onPress,
    required this.onDelete,
    required this.placeModel,
  }) : super(key: key);

  final double width, aspectRatio;
  final PlaceModel placeModel;
  final VoidCallback onPress;
  final VoidCallback onDelete;

  @override
  _AddedCardState createState() => _AddedCardState();
}

class _AddedCardState extends State<AddedCard> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {});
    }
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
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      widget.placeModel.images != null &&
                              widget.placeModel.images!.isNotEmpty
                          ? widget.placeModel.images![0]
                          : 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.18),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
                Positioned(
                  bottom: LayoutManager.widthNHeight0(context, 0) * 0.22,
                  left: LayoutManager.widthNHeight0(context, 0) * 0.008,
                  child: Center(
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
                            offset: Offset(2, 2),
                          ),
                        ],
                        color: ThemeManager.second,
                        fontFamily: ThemeManager.fontFamily,
                        fontWeight: FontWeight.w900,
                        fontSize: LayoutManager.widthNHeight0(context, 0) * 0.017,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: LayoutManager.widthNHeight0(context, 0) * 0.02,
                  left: LayoutManager.widthNHeight0(context, 0) * 0.075,
                  child: Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: widget.onDelete,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor:
                                ThemeManager.second.withOpacity(0.9),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: ThemeManager.primary,
                              fontWeight: FontWeight.w600,
                              fontFamily: ThemeManager.fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
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
