import 'package:flutter/material.dart';

// ThemeManager class to manage the application's theme colors and styles
class ThemeManager {
  // Primary color used throughout the app
  static Color primary = const Color(0xff6E232F);

  // Secondary color used for backgrounds and other elements
  static Color second = const Color(0xffF7F3EE);

// Background color for the app
  static Color background = const Color(0xffF0F2F6);

  // Color for text elements
  static Color textColor = const Color(0xff31221D);

  // Background color for containers
  static Color containerback = const Color(0xffE2D1B9);

  // Color for favorite icons
  static Color favIcon = const Color(0xFFA74040);

  // Font family used in the app
  static String fontFamily = 'KohSantepheap';

  // Default text style for the app
  static TextStyle textStyle = TextStyle(
      fontFamily: 'KohSantepheap',
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: 16);

  // Default button style for the app
  static ButtonStyle buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all(ThemeManager.second));
}
