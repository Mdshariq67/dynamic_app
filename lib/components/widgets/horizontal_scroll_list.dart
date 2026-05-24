import 'package:flutter/material.dart';

import 'section_header.dart';

class HorizontalScrollListWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const HorizontalScrollListWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final title = config['title'] as String? ?? '';

    if (title.isEmpty) return const SizedBox.shrink();

    return SectionHeaderWidget(config: {
      'title': title,
      'showSeeAll': config['showSeeAll'] ?? false,
    });
  }
}
