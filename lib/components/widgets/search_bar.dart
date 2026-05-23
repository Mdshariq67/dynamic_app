import 'package:flutter/material.dart';

import '../../config/preview_app_config.dart';
import '../utils/color_utils.dart';

class SearchBarWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const SearchBarWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final bgColor = ColorUtils.fromHex(
      config['backgroundColor'] as String? ?? '',
      Colors.grey.shade100,
    );
    final iconColor = ColorUtils.fromHex(
      config['iconColor'] as String? ?? '',
      PreviewAppConfig.primaryColor,
    );
    final borderRadius = (config['borderRadius'] as num?)?.toDouble() ?? 24.0;
    final placeholder = config['placeholder'] as String? ?? 'Search...';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/listing'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: iconColor, size: 20),
            const SizedBox(width: 10),
            Text(
              placeholder,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
