import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: _appBarTheme(),
      colorScheme: _getColorScheme(),
      // colorScheme: ColorScheme.fromSwatch(
      //   primaryColorDark: AppColors.yellow,
      // ),
      // textTheme: _getTextTheme(),
      elevatedButtonTheme: _getElevatedButtonThemeData(),
    );
  }
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    color: AppColors.yellow,
    titleTextStyle: TextStyle(
      fontSize: 16,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}

ColorScheme _getColorScheme() {
  return const ColorScheme.dark().copyWith(
    primary: AppColors.yellow,
    onPrimary: AppColors.white,
  );
}

TextTheme _getTextTheme() {
  return TextTheme(
    headlineLarge: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 22,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
  );
}

ElevatedButtonThemeData _getElevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(8.0),
      textStyle: AppTextStyles.poppinsNormal18.copyWith(color: AppColors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );
}
