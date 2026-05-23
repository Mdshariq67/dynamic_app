import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/preview_app_config.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final textTheme = GoogleFonts.getTextTheme(PreviewAppConfig.fontFamily);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PreviewAppConfig.primaryColor,
        primary: PreviewAppConfig.primaryColor,
        secondary: PreviewAppConfig.secondaryColor,
        tertiary: PreviewAppConfig.accentColor,
      ),
      primaryColor: PreviewAppConfig.primaryColor,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: PreviewAppConfig.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.getFont(
          PreviewAppConfig.fontFamily,
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
