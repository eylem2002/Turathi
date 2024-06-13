import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//page to view all places marked as favorite by the user
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  PlaceList? favoritePlaces;

  @override
  Widget build(BuildContext context) {
    String NoFavCase2= "SAVE YOUR FAVOURITE PLACE NOW!";
    String NoFavCase22= "It looks like you haven’t added any favourite place just yet.";
    PlaceProvider provider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        title: Center(
          child: Text(
            'WishList Page',
            style: TextStyle(
              fontSize: LayoutManager.widthNHeight0(context, 1) * 0.06,
              fontWeight: FontWeight.bold,
              fontFamily: 'KohSantepheap',
              color: ThemeManager.primary,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(top:LayoutManager.widthNHeight0(context, 1)*0.03),
        child: FutureBuilder(
          future: provider.placeList,
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: ThemeManager.primary,
                color: ThemeManager.second,
              ));
            }
            favoritePlaces = provider.getFavPlaces(data.places);
            if (favoritePlaces!.places.isNotEmpty) {
              log("${data.places.toList()}");
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: favoritePlaces!.places.length,
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final placeModel = favoritePlaces!.places[index];
                          return PlaceCard(
                            placeModel: placeModel,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    placeModel: placeModel,
                                  ),
                                ),
                              );
                            },

                          );
                        },
                      ),
                    ),
                  ],
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
                     NoFavCase2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeManager.primary,
                        fontFamily: ThemeManager.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                        height: LayoutManager.widthNHeight0(context, 1) * 0.025),
                    Text(
                    NoFavCase22 ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily:  ThemeManager.fontFamily,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
