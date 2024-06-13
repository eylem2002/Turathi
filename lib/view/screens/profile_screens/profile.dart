import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';


//page that provide actions on his profile and actions in the app
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(150.0),
                    bottomRight: Radius.circular(150.0),
                  ),
                  child: Transform.scale(
                    scale: 1.1,
                    child: Image.asset(
                      'assets/images/img_png/profile.png',
                      width: double.infinity,
                      height: LayoutManager.widthNHeight0(context, 1) * 0.54,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  top: LayoutManager.widthNHeight0(context, 1) * 0.155,
                  left: LayoutManager.widthNHeight0(context, 1) * 0.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi ${sharedUser.name}".toUpperCase(),//?? "Guest"
                        style: TextStyle(
                          fontSize:
                              LayoutManager.widthNHeight0(context, 1) * 0.06,
                          color: ThemeManager.second,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Welcome Again",
                        style: TextStyle(
                          fontSize:
                              LayoutManager.widthNHeight0(context, 1) * 0.06,
                          color: ThemeManager.second,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: LayoutManager.widthNHeight0(context, 1) * 0.03,
                right: LayoutManager.widthNHeight0(context, 1) * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.08,
                  ),
                  const FirstBoxWidget(),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.045,
                  ),
                  const SecondBoxWidget(),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.045,
                  ),
                  const ThirdBoxWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
