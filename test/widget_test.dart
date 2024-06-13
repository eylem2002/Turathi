import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/screens/places_details_screens/widgets/like_place_button.dart';

void main() {
  testWidgets('Like Place Button Test', (WidgetTester tester) async {
    PlaceModel placeModel = PlaceModel(
        latitude: 0,
        longitude: 0,
        address: "address",
        description: "description",
        title: 'title');
    placeModel.like = 4;
    placeModel.likesList = ['1', '2', '3', '4'];
    sharedUser = UserModel(
        name: 'name',
        email: 'email',
        phone: 'phone',
        longitude: 1,
        latitude: 1);
    sharedUser.id = '5';
    await tester.pumpWidget(MaterialApp(
      home: LikeButton(
        onLike: () {
          if (placeModel.likesList!.contains(sharedUser.id!))
            placeModel.likesList!.remove(sharedUser.id!);
          else
            placeModel.likesList!.add(sharedUser.id!);

          placeModel.like = placeModel.likesList!.length;
        },
        placeModel: placeModel,
      ),
    ));

    final image = tester.firstWidget<Image>(find.byType(Image));
    expect(image.image,
        equals(const AssetImage('assets/images/img_png/like.png')));

    await tester.tap(find.byType(IconButton));
    await tester.pump();
    final likedImage = tester.firstWidget<Image>(find.byType(Image));
    expect(likedImage.image,
        equals(const AssetImage('assets/images/img_png/like_filled.png')));
    await tester.tap(find.byType(IconButton));

    await tester.pump();
    final disLikedImage = tester.firstWidget<Image>(find.byType(Image));
    expect(disLikedImage.image,
        equals(const AssetImage('assets/images/img_png/like.png')));
  });
}
