import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//This to show me the Popular Place based on the likes (descending)
class PopularPlaceWidget extends StatelessWidget {
  const PopularPlaceWidget({super.key, required this.placeModel});

  final PlaceModel placeModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(placeDetailsRoute, arguments: placeModel);
      },
      child: Image.network(
        placeModel.images![0] != null && placeModel.images![0].isNotEmpty
            ? placeModel.images![0]
//if there is an image null or any problem of the connection (waitting the image to load) then show this image
            : 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
        fit: BoxFit.cover,
      ),
    );
  }
}
