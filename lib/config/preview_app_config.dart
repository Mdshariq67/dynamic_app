import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_config.dart';

/// Holds branding overrides read from URL query parameters when running on web.
/// Falls back to [AppConfig] values when no override is present.
///
/// URL param format:
///   ?primary=1A237E&secondary=7986CB&accent=E8EAF6
///   &appName=City+Library&description=Your+library
///   &fontFamily=Poppins&layout=grid
class PreviewAppConfig {
  PreviewAppConfig._();

  static Color? _primaryColor;
  static Color? _secondaryColor;
  static Color? _accentColor;
  static String? _appName;
  static String? _description;
  static String? _fontFamily;
  static String? _layout;

  /// Reads URL query parameters and stores any branding overrides.
  /// Must be called before [runApp] so the theme is built with the right colors.
  static void initFromUrl() {
    if (!kIsWeb) return;
    final params = Uri.base.queryParameters;
    _primaryColor = _parseHex(params['primary']);
    _secondaryColor = _parseHex(params['secondary']);
    _accentColor = _parseHex(params['accent']);
    _appName = params['appName'];
    _description = params['description'];
    _fontFamily = params['fontFamily'];
    _layout = params['layout'];
  }

  static Color get primaryColor => _primaryColor ?? AppConfig.primaryColor;
  static Color get secondaryColor => _secondaryColor ?? AppConfig.secondaryColor;
  static Color get accentColor => _accentColor ?? AppConfig.accentColor;
  static String get appName => _appName ?? AppConfig.appName;
  static String get description => _description ?? AppConfig.description;
  static String get fontFamily => _fontFamily ?? AppConfig.fontFamily;
  static String? get layout => _layout;

  static Color? _parseHex(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    try {
      final cleaned = hex.replaceAll('#', '');
      if (cleaned.length == 6) return Color(int.parse('FF$cleaned', radix: 16));
      if (cleaned.length == 8) return Color(int.parse(cleaned, radix: 16));
    } catch (_) {}
    return null;
  }
}
