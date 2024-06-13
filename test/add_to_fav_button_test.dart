import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/admin_screens/places_admin.dart';
import 'package:turathi/view/screens/places_details_screens/widgets/like_place_button.dart';
import 'package:turathi/view/widgets/place_card.dart';
class TestButton extends StatefulWidget {
   TestButton({super.key,required this.placeModel});
PlaceModel placeModel;

  @override
  State<TestButton> createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key("Button"),
      onPressed: ()  {
        if (sharedUser.favList!
            .contains(widget.placeModel.placeId!)) {
         setState(() {
           sharedUser.favList!.remove(widget.placeModel.placeId!);
         });
        } else {
       setState(() {
         sharedUser.favList!.add(widget.placeModel.placeId!);
       });

        }
      },
      icon: Icon(
        key: Key("Icon"),
        sharedUser.favList!.contains(widget.placeModel.placeId!)
            ? Icons.favorite
            : Icons.favorite_border_outlined,
        color: ThemeManager.primary,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}

void main() {
  testWidgets('Favorite Place Button Test', (WidgetTester tester) async {
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
      home: TestButton(placeModel: placeModel,)
    ));

    var icon = tester.firstWidget<Icon>(find.byKey(Key("Icon")));
    expect(icon.icon,
        equals(Icons.favorite_border_outlined));

    await tester.tap(find.byKey(Key("Button")));
    await tester.pump();
    final likedIcon = tester.firstWidget<Icon>(find.byKey(Key("Icon")));
    expect(likedIcon.icon,
        equals(Icons.favorite));

    expect(sharedUser.favList!.length, 1);
    await tester.tap(find.byKey(Key("Button")));
    await tester.pump();
    expect(sharedUser.favList!.length, 0);
  });
}
