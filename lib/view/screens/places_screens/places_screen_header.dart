import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//widget to provide user it's location and either update his location or choose any location
class HeaderPart extends StatefulWidget {
  HeaderPart({super.key, required this.tab});

  String tab;

  @override
  State<HeaderPart> createState() => _HeaderPartState();
}

class _HeaderPartState extends State<HeaderPart> {
  String _currentAddress = 'Waiting';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

  }

  Future<void> _getCurrentLocation() async {
    try {
       await UserCity(
          longitude: sharedUser.longitude!, latitude: sharedUser.latitude!).then((value) {
        if (mounted) {
          setState(() {
            _currentAddress = value;
          });
        }
      });

    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String urLocation='Your Location';
    String tab2Msg= "Choose The Nearest Point";
    String tab1Msg="Update My Location";
    var userProvider = Provider.of<UserProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             urLocation ,
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.primary,
                fontWeight: FontWeight.bold,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.015,
                shadows: const [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.grey,
                  size: LayoutManager.widthNHeight0(context, 0) * 0.015,
                ),
                SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                ),
                Text(
                  // _currentAddress != null ? _currentAddress! : 'Waiting',
                  _currentAddress,
                  style: TextStyle(
                    fontFamily: ThemeManager.fontFamily,
                    color: Colors.grey,
                    fontSize: LayoutManager.widthNHeight0(context, 0) * 0.014,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: LayoutManager.widthNHeight0(context, 1) * 0.028,
            ),
            if (widget.tab == "Nearest Place")
              _locationButton(
                  onTab: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NearestMap(),
                      ),
                    );
                  },
                  txt:tab2Msg)
            else
              _locationButton(
                  onTab: () {
                    userProvider.updateUserLocation().whenComplete(() async {
                      await _getCurrentLocation();
                    });
                      showDialog(
                        context: context,
                        builder: (context) {
                          return showCustomAlertDialog(context, "Your Location Updated Successfully");
                        },
                      );
                  },
                  txt:tab1Msg ),
            SizedBox(
              height: LayoutManager.widthNHeight0(context, 0) * 0.005,
            ),
          ],
        ),
      ),
      /////here
    );
  }

  Widget _locationButton(
      {required String txt, required void Function() onTab}) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: LayoutManager.widthNHeight0(context, 1) * 0.145,
        width: LayoutManager.widthNHeight0(context, 0),
        decoration: BoxDecoration(
          color: ThemeManager.second,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        
          border: Border.all(
            color: ThemeManager.primary,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              txt,
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.primary,
                fontWeight: FontWeight.bold,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.0175,
                shadows: const [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: LayoutManager.widthNHeight0(context, 0) * 0.015,
            ),
            Icon(
              Icons.map_outlined,
              color: ThemeManager.primary,
              size: LayoutManager.widthNHeight0(context, 0) * 0.023,
            )
          ],
        ),
      ),
    );
  }
}
