import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../../config/preview_app_config.dart';

class ItemCard extends StatelessWidget {
  final Map<String, dynamic> config;
  final String title;
  final String? description;
  final String? imageUrl;
  final double? width;
  final double? height;

  const ItemCard({
    super.key,
    required this.config,
    this.title = 'Item',
    this.description,
    this.imageUrl,
    this.width,
    this.height,
  });

  static MainAxisAlignment _mainAxis(String? val) => switch (val) {
        'center' => MainAxisAlignment.center,
        'end' => MainAxisAlignment.end,
        _ => MainAxisAlignment.start,
      };

  static CrossAxisAlignment _crossAxis(String? val) => switch (val) {
        'center' => CrossAxisAlignment.center,
        'end' => CrossAxisAlignment.end,
        _ => CrossAxisAlignment.start,
      };

  @override
  Widget build(BuildContext context) {
    final cardStyle = config['cardStyle'] as String? ?? 'elevated';
    final imagePosition = config['imagePosition'] as String? ?? 'top';
    final cardBorderRadius =
        (config['cardBorderRadius'] as num?)?.toDouble() ?? 12.0;
    final cardElevation =
        (config['cardElevation'] as num?)?.toDouble() ?? 2.0;
    final showDescription = config['showDescription'] as bool? ?? true;
    final showButton = config['showButton'] as bool? ?? false;
    final buttonLabel = config['buttonLabel'] as String? ?? 'View';
    final buttonAlignment = config['buttonAlignment'] as String?;
    final titleAlignment = config['titleAlignment'] as String?;
    final descLines = (config['descriptionLines'] as num?)?.toInt() ?? 2;
    final imageSize = (config['imageSize'] as num?)?.toDouble() ?? 80.0;

    final isHorizontal = imagePosition == 'left' ||
        imagePosition == 'right' ||
        cardStyle == 'image_left' ||
        cardStyle == 'image_right';

    Widget cardContent;
    if (isHorizontal) {
      final imageOnRight =
          imagePosition == 'right' || cardStyle == 'image_right';
      final imgWidget = ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: imageSize,
          height: imageSize,
          child: _buildImage(),
        ),
      );
      final textWidget = Expanded(
        child: _buildText(
          titleAlignment,
          showDescription,
          descLines,
          buttonAlignment,
          buttonLabel,
          showButton,
        ),
      );
      cardContent = Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: imageOnRight
              ? [textWidget, const SizedBox(width: 10), imgWidget]
              : [imgWidget, const SizedBox(width: 10), textWidget],
        ),
      );
    } else {
      // image top (default)
      cardContent = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildImage()),
          Padding(
            padding: const EdgeInsets.all(10),
            child: _buildText(
              titleAlignment,
              showDescription,
              descLines,
              buttonAlignment,
              buttonLabel,
              showButton,
            ),
          ),
        ],
      );
    }

    return Card(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(width: width, height: height, child: cardContent),
    );
  }

  Widget _buildImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (_, __) =>
            Container(color: PreviewAppConfig.primaryColor.withAlpha(40)),
        errorWidget: (_, __, ___) => _imagePlaceholder(),
      );
    }
    return _imagePlaceholder();
  }

  Widget _imagePlaceholder() {
    return Container(
      color: PreviewAppConfig.primaryColor.withAlpha(40),
      child: const Center(
        child: Icon(Icons.image_outlined, color: Colors.white54, size: 32),
      ),
    );
  }

  Widget _buildText(
    String? titleAlign,
    bool showDesc,
    int descLines,
    String? btnAlign,
    String btnLabel,
    bool showBtn,
  ) {
    return Column(
      crossAxisAlignment: _crossAxis(titleAlign),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (showDesc && description != null && description!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              description!,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              maxLines: descLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (showBtn)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              mainAxisAlignment: _mainAxis(btnAlign),
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppConfig.accentColor,
                    overlayColor: AppConfig.accentColor.withValues(alpha: 0.1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(btnLabel, style: const TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
