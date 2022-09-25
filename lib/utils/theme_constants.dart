import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_chat/utils/colors_constants.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: _getAppBarTheme(),
  colorScheme: _getCustomColorScheme(),
);

AppBarTheme _getAppBarTheme() {
  return AppBarTheme(
    backgroundColor: AppColors.appBarColor,
    titleTextStyle: GoogleFonts.playfairDisplay(
      color: AppColors.appBarTitleColor,
    ),
  );
}

ColorScheme _getCustomColorScheme() {
  return const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    onError: AppColors.onError,
    background: AppColors.primary,
    secondary: AppColors.onPrimary,
    onSecondary: AppColors.primary,
  );
}
