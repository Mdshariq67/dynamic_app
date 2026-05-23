import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/component_renderer.dart';
import '../config/preview_app_config.dart';
import '../config/ui_config_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            return _ShimmerList();
          }

          final screen = service.config.screens['home'];
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
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _ShimmerBox(height: 200),
        const SizedBox(height: 16),
        const _ShimmerBox(height: 52),
        const SizedBox(height: 16),
        const _ShimmerBox(height: 180),
        const SizedBox(height: 16),
        const _ShimmerBox(height: 300),
      ],
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
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
