import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';


class ThirdBoxWidget extends StatefulWidget {
  const ThirdBoxWidget({super.key});

  @override
  State<ThirdBoxWidget> createState() => _thirdBox();
}

class _thirdBox extends State<ThirdBoxWidget> {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
   

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: const Color(0xffF7F3EE),
      ),
      child: Container(
          height: LayoutManager.widthNHeight0(context, 1) * 0.3,
          padding:
              EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.05),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(aboutUsScreen);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_png/infoProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.03,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.054,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'About us',
                            style: TextStyle(
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.038,
                                fontFamily: ThemeManager.fontFamily,
                                color: ThemeManager.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.05,
              ),
              InkWell(
                onTap: () {
               
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: GestureDetector(
                    onTap: () async {
                     await userService.signOut();

                      print("sign out");

                      Navigator.of(context).pushReplacementNamed(signIn);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.login_outlined,
                          size: LayoutManager.widthNHeight0(context, 1) * 0.045,
                          color: Color(0xff263238),
                        ),
                        SizedBox(
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.02),
                        Text(
                          'Sign out',
                          style: TextStyle(
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 1) *
                                      0.038,
                              color: ThemeManager.primary,
                              fontFamily: ThemeManager.fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
