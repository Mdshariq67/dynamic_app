import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_config.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppConfig.primaryColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 40),
          child: Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white24,
                child: ClipOval(
                  child: Image.asset(
                    AppConfig.logoPath,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.business,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppConfig.appName,
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  AppConfig.fontFamily,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppConfig.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  AppConfig.fontFamily,
                  fontSize: 14,
                  color: AppConfig.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
