import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../utils/color_utils.dart';

class EmptyStateWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const EmptyStateWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final title = config['title'] as String? ?? 'Nothing here yet';
    final subtitle = config['subtitle'] as String? ?? '';
    final iconColor = ColorUtils.fromHex(
      config['iconColor'] as String? ?? '',
      AppConfig.primaryColor,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: iconColor.withAlpha(128)),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
