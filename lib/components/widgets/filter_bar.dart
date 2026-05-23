import 'package:flutter/material.dart';

import '../../config/preview_app_config.dart';
import '../utils/color_utils.dart';

class FilterBarWidget extends StatefulWidget {
  final Map<String, dynamic> config;

  const FilterBarWidget({super.key, required this.config});

  @override
  State<FilterBarWidget> createState() => _FilterBarWidgetState();
}

class _FilterBarWidgetState extends State<FilterBarWidget> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    final filters = widget.config['filters'] as List<dynamic>?;
    _selected = filters?.isNotEmpty == true ? filters!.first.toString() : 'All';
  }

  @override
  Widget build(BuildContext context) {
    final filters = (widget.config['filters'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        ['All'];
    final selectedColor = ColorUtils.fromHex(
      widget.config['selectedColor'] as String? ?? '',
      PreviewAppConfig.primaryColor,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selected == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              selectedColor: selectedColor.withAlpha(40),
              checkmarkColor: selectedColor,
              labelStyle: TextStyle(
                color: isSelected ? selectedColor : Colors.black87,
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => setState(() => _selected = filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}
