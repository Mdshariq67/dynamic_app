import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../../config/preview_app_config.dart';
import '../utils/color_utils.dart';

class HeroBannerWidget extends StatelessWidget {
  final Map<String, dynamic> config;

  const HeroBannerWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final imageUrl = config['imageUrl'] as String? ?? '';
    final title = config['title'] as String? ?? PreviewAppConfig.appName;
    final subtitle = config['subtitle'] as String? ?? '';
    final bgColor = ColorUtils.fromHex(
      config['backgroundColor'] as String? ?? '',
      PreviewAppConfig.primaryColor,
    );
    final textColor = ColorUtils.fromHex(
      config['textColor'] as String? ?? '',
      Colors.white,
    );
    final height = (config['height'] as num?)?.toDouble() ?? 200.0;
    final borderRadius = (config['borderRadius'] as num?)?.toDouble() ?? 12.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: bgColor),
                errorWidget: (_, __, ___) => Container(color: bgColor),
              )
            else
              Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: bgColor),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Image.asset(
                        AppConfig.logoPath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_outlined,
                          color: Colors.white54,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(128),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: textColor.withAlpha(230),
                        fontSize: 14,
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
