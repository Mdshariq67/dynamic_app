import 'package:flutter/material.dart';

import 'item_card.dart';
import 'section_header.dart';

class HorizontalScrollListWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const HorizontalScrollListWidget({super.key, required this.config});

  static const _placeholders = [
    ('Featured 1', 'Description one.'),
    ('Featured 2', 'Description two.'),
    ('Featured 3', 'Description three.'),
    ('Featured 4', 'Description four.'),
    ('Featured 5', 'Description five.'),
  ];

  @override
  Widget build(BuildContext context) {
    final title = config['title'] as String? ?? '';
    final cardWidth = (config['cardWidth'] as num?)?.toDouble() ?? 160.0;
    final cardHeight = (config['cardHeight'] as num?)?.toDouble() ?? 200.0;
    final spacing = (config['spacing'] as num?)?.toDouble() ?? 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SectionHeaderWidget(config: {
              'title': title,
              'showSeeAll': config['showSeeAll'] ?? false,
            }),
          ),
        SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _placeholders.length,
            separatorBuilder: (_, __) => SizedBox(width: spacing),
            itemBuilder: (_, i) => SizedBox(
              width: cardWidth,
              child: ItemCard(
                config: config,
                title: _placeholders[i].$1,
                description: _placeholders[i].$2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
