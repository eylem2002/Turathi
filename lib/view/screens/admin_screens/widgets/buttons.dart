import 'package:flutter/material.dart';

import '../../../../core/data_layer.dart';
import '../../../view_layer.dart';


class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.txt, required this.routeName});
  final String routeName;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            height: 100,
            color: ThemeManager.primary,
            child: Center(
              child: InkWell(
                child: Text(
                  txt,
                  style: ThemeManager.textStyle
                      .copyWith(color: ThemeManager.second),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(routeName);
                },
              ),
            )),
      ),
    );
  }
}
    UserService userService = UserService();
class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: LayoutManager.widthNHeight0(context, 1)*0.4),
      child: TextButton(
        onPressed: () async {
          await userService.signOut();
      
          print("Sign out");
      
          Navigator.of(context).pushReplacementNamed(signIn);
        },
        child: Text(
          "SignOut",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: ThemeManager.fontFamily,
              color: ThemeManager.primary),
        )),
    );
  }
}


List buttonsList = [
  ButtonWidget(txt: "Reports", routeName: allReportsAdminRoute),
  ButtonWidget(txt: "Places", routeName: placesAdminRoute),
  ButtonWidget(txt: "Requests", routeName: requestsAdminRoute),
  ButtonWidget(txt: "Events", routeName: eventsAdminRoute),
  TextWidget(),
];
