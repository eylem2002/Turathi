import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(
        imageUrl: placeModel.images!.isNotEmpty
            ? placeModel.images!.first
            : 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
        fit: BoxFit.cover,
        placeholder: (context, _) => Container(
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
      ),
    );
  }
}
