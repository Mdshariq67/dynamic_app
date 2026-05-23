import 'package:flutter/material.dart';

import '../config/ui_config.dart';
import 'widgets/empty_state.dart';
import 'widgets/filter_bar.dart';
import 'widgets/hero_banner.dart';
import 'widgets/horizontal_scroll_list.dart';
import 'widgets/item_grid.dart';
import 'widgets/item_list.dart';
import 'widgets/promo_banner.dart';
import 'widgets/search_bar.dart';
import 'widgets/section_header.dart';

class ComponentRenderer extends StatelessWidget {
  final UiComponent component;

  const ComponentRenderer({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    if (!component.visible) return const SizedBox.shrink();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(
        key: ValueKey('${component.id}_${component.type}'),
        child: _resolve(context),
      ),
    );
  }

  Widget _resolve(BuildContext context) {
    switch (component.type) {
      case 'hero_banner':
        return HeroBannerWidget(config: component.config);
      case 'search_bar':
        return SearchBarWidget(config: component.config);
      case 'section_header':
        return SectionHeaderWidget(config: component.config);
      case 'item_grid':
        return ItemGridWidget(config: component.config);
      case 'item_list':
        return ItemListWidget(config: component.config);
      case 'horizontal_scroll_list':
        return HorizontalScrollListWidget(config: component.config);
      case 'filter_bar':
        return FilterBarWidget(config: component.config);
      case 'promo_banner':
        return PromoBannerWidget(config: component.config);
      case 'empty_state':
        return EmptyStateWidget(config: component.config);
      default:
        return const SizedBox.shrink();
    }
  }
}
