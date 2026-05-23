import 'package:flutter/material.dart';

import '../../config/preview_app_config.dart';

class SectionHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const SectionHeaderWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final title = config['title'] as String? ?? '';
    final showSeeAll = config['showSeeAll'] as bool? ?? false;
    final paddingH = (config['paddingHorizontal'] as num?)?.toDouble() ?? 0.0;
    final paddingV = (config['paddingVertical'] as num?)?.toDouble() ?? 8.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: PreviewAppConfig.primaryColor,
            ),
          ),
          if (showSeeAll)
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/listing'),
              child: Text(
                'See all',
                style: TextStyle(color: PreviewAppConfig.primaryColor),
              ),
            ),
        ],
      ),
    );
  }
}
