import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/preview_app_config.dart';
import '../utils/color_utils.dart';

class PromoBannerWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const PromoBannerWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final imageUrl = config['imageUrl'] as String? ?? '';
    final title = config['title'] as String? ?? '';
    final subtitle = config['subtitle'] as String? ?? '';
    final bgColor = ColorUtils.fromHex(
      config['backgroundColor'] as String? ?? '',
      PreviewAppConfig.secondaryColor,
    );
    final textColor = ColorUtils.fromHex(
      config['textColor'] as String? ?? '',
      Colors.white,
    );
    final borderRadius = (config['borderRadius'] as num?)?.toDouble() ?? 12.0;
    final height = (config['height'] as num?)?.toDouble() ?? 120.0;
    final buttonLabel = config['buttonLabel'] as String?;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: bgColor),
            if (imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const SizedBox.shrink(),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: textColor.withAlpha(230),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  if (buttonLabel != null && buttonLabel.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(buttonLabel),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
