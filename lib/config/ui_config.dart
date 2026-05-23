import 'app_config.dart';

class UiComponent {
  final String id;
  final String type;
  final bool visible;
  final int order;
  final Map<String, dynamic> config;

  const UiComponent({
    required this.id,
    required this.type,
    required this.visible,
    required this.order,
    required this.config,
  });

  factory UiComponent.fromJson(Map<String, dynamic> json) {
    return UiComponent(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      visible: json['visible'] as bool? ?? true,
      order: (json['order'] as num?)?.toInt() ?? 0,
      config: Map<String, dynamic>.from(json['config'] as Map? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'visible': visible,
        'order': order,
        'config': config,
      };
}

class UiScreen {
  final List<UiComponent> components;

  const UiScreen({required this.components});

  factory UiScreen.fromJson(Map<String, dynamic> json) {
    final raw = json['components'] as List<dynamic>? ?? [];
    return UiScreen(
      components: raw
          .map((c) => UiComponent.fromJson(Map<String, dynamic>.from(c as Map)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'components': components.map((c) => c.toJson()).toList(),
      };
}

class UiConfig {
  final int version;
  final String updatedAt;
  final Map<String, UiScreen> screens;
  final Map<String, dynamic> globalConfig;

  const UiConfig({
    required this.version,
    required this.updatedAt,
    required this.screens,
    required this.globalConfig,
  });

  factory UiConfig.fromJson(Map<String, dynamic> json) {
    final rawScreens = json['screens'] as Map<String, dynamic>? ?? {};
    return UiConfig(
      version: (json['version'] as num?)?.toInt() ?? 1,
      updatedAt: json['updatedAt'] as String? ?? '',
      screens: rawScreens.map(
        (key, value) => MapEntry(
          key,
          UiScreen.fromJson(Map<String, dynamic>.from(value as Map)),
        ),
      ),
      globalConfig: Map<String, dynamic>.from(
        json['globalConfig'] as Map? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'updatedAt': updatedAt,
        'screens': screens.map((k, v) => MapEntry(k, v.toJson())),
        'globalConfig': globalConfig,
      };

  factory UiConfig.defaultConfig() {
    return UiConfig(
      version: 0,
      updatedAt: '',
      globalConfig: {},
      screens: {
        'home': UiScreen(components: [
          UiComponent(
            id: 'default_banner',
            type: 'hero_banner',
            visible: true,
            order: 0,
            config: {
              'title': AppConfig.appName,
              'subtitle': AppConfig.description,
              'backgroundColor': '',
              'textColor': '',
              'height': 200,
              'borderRadius': 12,
            },
          ),
          UiComponent(
            id: 'default_search',
            type: 'search_bar',
            visible: true,
            order: 1,
            config: {
              'placeholder': 'Search...',
              'borderRadius': 24,
            },
          ),
          UiComponent(
            id: 'default_grid',
            type: 'item_grid',
            visible: true,
            order: 2,
            config: {
              'title': 'All Items',
              'columns': 2,
              'spacing': 12,
              'cardStyle': 'elevated',
              'imagePosition': 'top',
              'showDescription': true,
              'showButton': true,
              'buttonLabel': 'View',
              'buttonAlignment': 'center',
              'cardBorderRadius': 12,
              'cardElevation': 2,
            },
          ),
        ]),
        'listing': UiScreen(components: [
          UiComponent(
            id: 'default_list',
            type: 'item_list',
            visible: true,
            order: 0,
            config: {
              'layout': 'vertical',
              'cardStyle': 'image_left',
              'imageSize': 80,
              'spacing': 8,
              'showDivider': true,
              'cardBorderRadius': 8,
              'titleAlignment': 'start',
              'descriptionLines': 2,
              'showButton': true,
              'buttonLabel': 'View',
              'buttonAlignment': 'end',
            },
          ),
        ]),
      },
    );
  }
}
