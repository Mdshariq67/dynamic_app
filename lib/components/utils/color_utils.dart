import 'package:flutter/material.dart';

class ColorUtils {
  ColorUtils._();

  static Color fromHex(String hex, Color fallback) {
    if (hex.isEmpty) return fallback;
    try {
      final cleaned = hex.replaceAll('#', '');
      if (cleaned.length == 6) {
        return Color(int.parse('FF$cleaned', radix: 16));
      } else if (cleaned.length == 8) {
        return Color(int.parse(cleaned, radix: 16));
      }
    } catch (_) {}
    return fallback;
  }
}
