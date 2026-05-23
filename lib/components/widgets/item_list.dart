import 'package:flutter/material.dart';

import 'item_card.dart';

class ItemListWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const ItemListWidget({super.key, required this.config});

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
    final spacing = (config['spacing'] as num?)?.toDouble() ?? 8.0;
    final showDivider = config['showDivider'] as bool? ?? false;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _placeholders.length,
      separatorBuilder: (_, __) =>
          showDivider ? const Divider(height: 1) : SizedBox(height: spacing),
      itemBuilder: (_, i) => ItemCard(
        config: config,
        title: _placeholders[i].$1,
        description: _placeholders[i].$2,
      ),
    );
  }
}
