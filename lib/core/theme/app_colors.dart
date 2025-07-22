import 'package:flutter/material.dart';

/// This class contains all the colors of the app.
class AppColors {
  //Brand Colors
  static const Color scaffoldColor = Color(0xffF5F5F5);
  static const Color fontColor = Color(0xff80908f);
  static const Color fontColor2 = Color(0xff9ca2ad);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color primaryColor = Color(0xff0057ff);
  static const Color greyColor = Color(0xff868686);
  static Color dangerColor = const Color(0xffD64545);
  static Color purpleColor = const Color(0xff905bfe);

  static const MaterialColor primarySwatch = MaterialColor(
    0xff0057ff,
    <int, Color>{
      50: Color(0xFFE3F0FF),
      100: Color(0xFFC2DEFF),
      200: Color(0xFF99C5FF),
      300: Color(0xFF66A9FF),
      400: Color(0xFF338CFF),
      500: Color(0xFF0057FF),
      600: Color(0xFF004EE5),
      700: Color(0xFF0042CC),
      800: Color(0xFF0037B3),
      900: Color(0xFF002080),
    },
  );

  //grey
  static const MaterialColor greySwatch = MaterialColor(
    0xFFA39F9F,
    <int, Color>{
      50: Color(0xfff8f8f8),
      100: Color(0xFFF0EFEF),
      200: Color(0xFFE9E8E8),
      300: Color(0xFFDAD8D8),
      400: Color(0xFFC6C3C3),
      500: Color(0xFFA39F9F),
      600: Color(0xFF6b6b6b),
      700: Color(0xFF4D4949),
      800: Color(0xFF333232),
      900: Color(0xFF262525),
    },
  );

  //danger
  static const MaterialColor secondarySwatch = MaterialColor(
    0xFFBC2A23,
    <int, Color>{
      50: Color(0xFFF8E8E7),
      100: Color(0xFFF2D4D3),
      200: Color(0xFFE4AAA7),
      300: Color(0xFFD77F7B),
      400: Color(0xFFC9554F),
      500: Color(0xFFBC2A23),
      600: Color(0xFF962923),
      700: Color(0xFF712724),
      800: Color(0xFF3C2625),
      900: Color(0xFF413130),
    },
  );

  //success
  static const MaterialColor successSwatch = MaterialColor(
    0xFF35C75A,
    <int, Color>{
      50: Color(0xFFEAFDE7),
      100: Color(0xFFDCFCD7),
      200: Color(0xFFB2F9B0),
      300: Color(0xFF85EE8B),
      400: Color(0xFF63DD76),
      500: Color(0xFF35C75A),
      600: Color(0xFF26AB55),
      700: Color(0xFF1A8F4E),
      800: Color(0xFF107346),
      900: Color(0xFF304133),
    },
  );
}
