import 'package:flutter/material.dart';
import 'package:turathi/view/view_layer.dart';


class SecondBoxWidget extends StatefulWidget {
  const SecondBoxWidget({super.key});

  @override
  State<SecondBoxWidget> createState() => _secondBox();
}

class _secondBox extends State<SecondBoxWidget> {
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
                
                     Navigator.of(context).pushNamed(addedPlacesRoute);
               
                },

                
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_png/imageProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.03,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.06,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'View added places',
                            style: TextStyle(
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.038,
                                fontFamily:ThemeManager.fontFamily,
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
                
                    Navigator.of(context).pushNamed(requestToBeExpertRoute);
                },

               
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_png/expertProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.03,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.06,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'Request to be Expert',
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
            ],
          )),
    );
  }
}



                  