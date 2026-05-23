import 'package:flutter/material.dart';

import 'item_card.dart';
import 'section_header.dart';

class ItemGridWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const ItemGridWidget({super.key, required this.config});

  static const _placeholders = [
    ('Item 1', 'Short description for item one.'),
    ('Item 2', 'Short description for item two.'),
    ('Item 3', 'Short description for item three.'),
    ('Item 4', 'Short description for item four.'),
    ('Item 5', 'Short description for item five.'),
    ('Item 6', 'Short description for item six.'),
  ];

  @override
  Widget build(BuildContext context) {
    final title = config['title'] as String? ?? '';
    final columns = (config['columns'] as num?)?.toInt() ?? 2;
    final spacing = (config['spacing'] as num?)?.toDouble() ?? 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          SectionHeaderWidget(config: {'title': title}),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 0.72,
          ),
          itemCount: _placeholders.length,
          itemBuilder: (_, i) => ItemCard(
            config: config,
            title: _placeholders[i].$1,
            description: _placeholders[i].$2,
          ),
        ),
      ],
    );
  }
}
