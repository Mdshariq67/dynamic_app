import 'package:flutter/material.dart';

// Local-dev fallback — committed to version control.
// The real app_config.dart is auto-generated at build time and is gitignored.
//
// Setup:
//   cp lib/config/app_config.template.dart lib/config/app_config.dart
//
// Per-client values the build system injects:
//
//   appName        Brand name shown throughout the app
//   description    Tagline shown as subtitle on the home screen
//   primaryColor   Dominant colour — header background, AppBar, card borders
//   secondaryColor Subtitle text colour (must contrast against primaryColor bg)
//   accentColor    Button backgrounds (must contrast against white bg)
//   fontFamily     One of: Poppins | Roboto | Lato | Montserrat | Nunito
//   logoPath       Always "assets/logo.png" (the file is swapped per build)

class AppConfig {
  AppConfig._();

  static const String appName = 'City Library';
  static const String description = 'Discover books, connect with stories.';
  static const Color primaryColor = Color(0xFF1A237E);
  static const Color secondaryColor = Color(0xFF7986CB);
  static const Color accentColor = Color(0xFFE8EAF6);
  static const String fontFamily = 'Poppins';
  static const String logoPath = 'assets/logo.png';
}
