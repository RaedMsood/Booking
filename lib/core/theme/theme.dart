import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  primarySwatch: AppColors.primarySwatch,
  splashColor: AppColors.primaryColor.withOpacity(.1),
  highlightColor: AppColors.primaryColor.withOpacity(.1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,

    ),
  ),
  tabBarTheme: TabBarTheme(
    dividerColor: AppColors.transparent,
    labelColor: AppColors.greyColor,
    unselectedLabelColor: AppColors.greyColor,
    indicatorColor: Colors.transparent,
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return AppColors.primaryColor;
      },
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(
      borderSide: const BorderSide(width: 2, color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(12),
      insets: const EdgeInsets.symmetric(horizontal: 14),
    ),
    dividerHeight: 0.0,
    tabAlignment: TabAlignment.center,
  ),
  fontFamily: 'ReadexPro',
);
