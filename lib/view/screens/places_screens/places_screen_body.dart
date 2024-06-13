import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//page to view all places based on location -selected or user location
class BodyPlaces extends StatefulWidget {
  final String tab;
  final int dis_num;
  var dataList;

  BodyPlaces(
      {Key? key,
      required this.tab,
      required this.dis_num,
      required this.dataList})
      : super(key: key);

  @override
  State<BodyPlaces> createState() => _BodyPlacesState();
}

class _BodyPlacesState extends State<BodyPlaces> {
  bool get isNearestPlaceTab => widget.tab == "Nearest Place";
  bool get isMyLocationTab => widget.tab == "My Location";
  PlaceList? placesList;
  String case2NoSelectedPlace = "You Have To Choose";
  String case22NoSelectedPlace = "The Location You Want";

  String case2NoPlaceNearestUserLoacation= "There IS No Places";
  String case22NoPlaceNearestUserLoacation=  "Nearest Your Location";

  @override
  Widget build(BuildContext context) {
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;

    int crossAxisCount =
        MediaQuery.of(context).size.width ~/ totalWidth; //number of col
    final PlaceProvider placesProvider = Provider.of<PlaceProvider>(context);

    if (isMyLocationTab) {
      widget.dataList.addAll([sharedUser.latitude, sharedUser.longitude]);
    } else {
      widget.dataList.addAll([selectedNearestLat, selectedNearestLog]);
    }

    if (widget.dataList.first == 0.0 || widget.dataList.last == 0.0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: LayoutManager.widthNHeight0(context, 1) * 0.45),
          child: Column(
            children: [
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.02),
              Text(
                case2NoSelectedPlace,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeManager.primary,
                  fontFamily: ThemeManager.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.025),
              Text(
                case22NoSelectedPlace,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: placesProvider.getNearestPlaceList(
          widget.dataList.first, widget.dataList.last, widget.dis_num),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        placesList = data;
        if (placesList!.places.isNotEmpty) {
          return Padding(
            padding: EdgeInsets.only(
                top: LayoutManager.widthNHeight0(context, 1) * 0.04,
                left: LayoutManager.widthNHeight0(context, 1) * 0.035,
                right: LayoutManager.widthNHeight0(context, 1) * 0.035),
            child: GridView.builder(
              itemCount: placesList!.places.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: cardWidth / (cardWidth + 65),
                mainAxisSpacing: 8, //between top
                crossAxisSpacing: 16, //between
              ),
              itemBuilder: (context, index) {
                final placeModel = placesList!.places[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      placeDetailsRoute,
                      arguments: placeModel,
                    );
                  },
                  child: SizedBox(
                    width: cardWidth,
                    child: PlaceCard(
                      placeModel: placeModel,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              placeModel: placeModel,
                              // dis_num
                            ),
                            ////
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: LayoutManager.widthNHeight0(context, 1) * 0.45),
            child: Column(
              children: [
                SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.02),
                Text(
                 case2NoPlaceNearestUserLoacation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.primary,
                    fontFamily:ThemeManager.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.025),
                 Text(
                 case22NoPlaceNearestUserLoacation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: ThemeManager.fontFamily,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
