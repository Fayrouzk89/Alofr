import 'package:flutter/material.dart';

class ColorConstants {
  static Color kPrimaryColor = Color(0xFF0C9869);
  static Color kTextColor = Color(0xFF3C4046);
  static Color kBackgroundColor = Color(0xFFF9F8FD);
  static Color greyBack = Color(0xFFf2f4f3);

  static double categoryWidth = 0.18;


  static double productWidth = 0.4;
  static double productHeight = 0.43;
  static double productHeightList = 0.43;
  static double sliderHeight = 200;

  static double productImgWidth = 0.4;


  static double kDefaultPadding = 20.0;
  static Color lightScaffoldBackgroundColor = hexToColor('#4BAE4F');
  static Color darkScaffoldBackgroundColor = hexToColor('#4BAE4F');
  static Color secondaryAppColor = hexToColor('#9F9F9F');
  static Color secondaryDarkAppColor = hexToColor('#9F9F9F');
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = Color(0xFFF6F6F6);
  static Color darkGray = Color(0xFF9F9F9F);
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);
  static Color whiteBack = Color(0xFFFFFFFF);
  static Color hintColor = Color(0xFF9F9F9F);
  static Color textColor = Color(0xFF000000);
  static Color filled=Color(0xFF2962FF);
  static Color notActiveColor= Color(0xFFE6E6DF);
  static Color blue=Color(0xFF2962FF);
  static Color yellow= Color(0xFFF57F17);
  static Color textColorBlue= Color(0xFF288CFF);

  static var colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static var colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );
  static Color greenColor = hexToColor('#4BAE4F');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );

}