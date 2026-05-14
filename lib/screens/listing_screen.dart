import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../widgets/item_card.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: 6,
        itemBuilder: (context, index) => ItemCard(index: index),
      ),
    );
  }
}
