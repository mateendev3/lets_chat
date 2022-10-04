import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors_constants.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.scaffoldBG,
  appBarTheme: _getAppBarTheme(),
  colorScheme: _getCustomColorScheme(),
  textTheme: GoogleFonts.poppinsTextTheme(
    _getTextTheme(),
  ),
);

AppBarTheme _getAppBarTheme() {
  return AppBarTheme(
    backgroundColor: AppColors.appBar,
    titleTextStyle: GoogleFonts.poppins(
      color: AppColors.appBarTitle,
      fontSize: 20.0,
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    actionsIconTheme: const IconThemeData(color: AppColors.white),
  );
}

TextTheme _getTextTheme() {
  return TextTheme(
    headlineSmall: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: GoogleFonts.poppins(
      color: AppColors.black,
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: AppColors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: AppColors.lightBlack,
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.poppins(
      color: AppColors.lightBlack,
      fontSize: 10.0,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: GoogleFonts.poppins(
      color: AppColors.chatOffWhite,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
    ),
  );
}

ColorScheme _getCustomColorScheme() {
  return const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.primary,
    onError: AppColors.onError,
    background: AppColors.primary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
  );
}
