

import 'package:flutter/material.dart';
import 'package:turathi/view/view_layer.dart';


Widget defaultButton({
  double width = double.infinity,
  double height = 50.0,
  Color borderColor = const Color(0xff6E232F),
  Color background = const Color(0xff6E232F),
  Color textColor = const Color(0xffF7F3EE),
  final Function()? function,
  required String text,
  double borderRadius = 0.0,
  required void Function() onPressed,
  required int borderWidth, // Change this line
}) =>
    Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
        color: background,
         boxShadow: [
          BoxShadow(
            color: ThemeManager.primary.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        onPressed: onPressed, // Change this line
        child: Text(
          text,
          style:ThemeManager.textStyle.copyWith( shadows: <Shadow>[
            Shadow(
              offset: Offset(-2.0, 2.0),
              blurRadius: 1.0,
              color: Colors.white.withOpacity(0.2),

            ),
          ],color: ThemeManager.second)
        ),
      ),
    );
