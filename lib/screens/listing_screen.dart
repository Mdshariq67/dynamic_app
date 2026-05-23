import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/component_renderer.dart';
import '../config/preview_app_config.dart';
import '../config/ui_config_service.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PreviewAppConfig.appName),
        backgroundColor: PreviewAppConfig.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<UiConfigService>(
        builder: (context, service, _) {
          if (service.state == ConfigState.loading) {
            return _buildShimmer();
          }

          final screen = service.config.screens['listing'];
          if (screen == null || screen.components.isEmpty) {
            return const Center(child: Text('No content configured.'));
          }

          final sorted = [...screen.components]
            ..sort((a, b) => a.order.compareTo(b.order));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sorted.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ComponentRenderer(component: sorted[i]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: List.generate(
        5,
        (i) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ShimmerBox(height: i == 0 ? 48 : 90),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatefulWidget {
  final double height;

  const _ShimmerBox({required this.height});

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.35, end: 0.75).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (_, __) => Opacity(
        opacity: _opacity.value,
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
