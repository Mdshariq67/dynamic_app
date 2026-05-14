import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_config.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final textTheme = GoogleFonts.getTextTheme(AppConfig.fontFamily);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConfig.primaryColor,
        primary: AppConfig.primaryColor,
        secondary: AppConfig.secondaryColor,
        tertiary: AppConfig.accentColor,
      ),
      primaryColor: AppConfig.primaryColor,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.getFont(
          AppConfig.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }
}
