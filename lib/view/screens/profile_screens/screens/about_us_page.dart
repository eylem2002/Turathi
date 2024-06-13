import 'package:flutter/material.dart';
import 'package:turathi/view/view_layer.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Added Places',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            Padding(
              padding: EdgeInsets.only(
                  top: LayoutManager.widthNHeight0(context, 1) * 0.1),
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: ThemeManager.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Problem',
                        style: TextStyle(
                          color: ThemeManager.second,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                          fontSize:
                              LayoutManager.widthNHeight0(context, 1) * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: LayoutManager.widthNHeight0(context, 1) * 0.03,
                      ),
                      Text(
                        'Many travelers, both local and international, often overlook lesser-known places in Jordanian cities because there isnt enough easy-to-find information about them.The main issue is that people who want to explore something face a problem because they must deal with a confusing mix of information from different sources. This complicated situation not only makes people less interested in exploring but also takes up a lot of their time that could be better used for enjoying the experience.  Its like solving a tricky puzzle with pieces scattered everywhere.',
                        style: TextStyle(
                          color: ThemeManager.second,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: LayoutManager.widthNHeight0(context, 1) * 0.1,
            ),
            Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ThemeManager.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Our Values',
                      style: TextStyle(
                        color: ThemeManager.second,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                        fontSize:
                            LayoutManager.widthNHeight0(context, 1) * 0.04,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.03,
                    ),
                    Text(
                      'We want to make it simple for everyone to discover and learn about historical places in Jordan without having to search all over the place, in a way thats easy to understand to avoid makes them confusing , feel lost and stressed.',
                      style: TextStyle(
                        color: ThemeManager.second,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            SizedBox(
              height: LayoutManager.widthNHeight0(context, 1) * 0.1,
            ),
            Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ThemeManager.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Overview",
                      style: TextStyle(
                        color: ThemeManager.second,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            LayoutManager.widthNHeight0(context, 1) * 0.05,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.03,
                    ),
                    Text(
                      " Tourism within Jordan plays a vital role in the country's income. Our app is like your friendly guide, providing a complete tour package to explore hidden spots in Jordan.Our main mission is to make information easy to find and organized",
                      style: TextStyle(
                        color: ThemeManager.second,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
           
          ],
        ),
      ),
    );
  }
}
