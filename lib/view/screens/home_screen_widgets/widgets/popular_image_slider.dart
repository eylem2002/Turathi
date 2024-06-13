import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//widget that shows the place images as slider
class ImageSliderWidget extends StatefulWidget {
  ImageSliderWidget({super.key});

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  PlaceList? popularPlaces;

  @override
  Widget build(BuildContext context) {
    PlaceProvider placesProvider = Provider.of<PlaceProvider>(context);
    return FutureBuilder(
        future: placesProvider.getMostPopularPlaces(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Center(child: CircularProgressIndicator(backgroundColor: ThemeManager.primary,color: ThemeManager.second,));
          }
          popularPlaces = data;
          if (popularPlaces!.places.isNotEmpty) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ImageSlideshow(
                width:LayoutManager.widthNHeight0(context, 1)*1,
                height: LayoutManager.widthNHeight0(context, 1)*0.58,
                initialPage: 0,
                indicatorRadius: 6,
                indicatorColor: ThemeManager.second,
                indicatorBackgroundColor: Color.fromRGBO(172, 166, 157, 1),
                autoPlayInterval: 3000,
                isLoop: true,
                children: popularPlaces!.places!.map((place) {
                  return PopularPlaceWidget(placeModel: place);
                }).toList(),
              ),
            );
          }
          return Center(child: Text("No Places Yet"));
        });
  }

}
