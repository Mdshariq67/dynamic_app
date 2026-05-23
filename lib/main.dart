import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'config/preview_app_config.dart';
import 'config/ui_config_service.dart';
import 'firebase_options.dart';
import 'preview/preview_bridge.dart';
import 'screens/home_screen.dart';
import 'screens/listing_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Read URL query params before the theme is built so preview colors apply.
  PreviewAppConfig.initFromUrl();

  bool firebaseReady = false;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
    firebaseReady = true;
  } catch (e) {
    debugPrint('[Firebase] init skipped — running in offline mode: $e');
  }

  final configService = UiConfigService();
  await configService.loadConfig(AppConfig.appSlug);

  if (firebaseReady) {
    configService.listenToChanges(AppConfig.appSlug);
  }

  runApp(
    ChangeNotifierProvider.value(
      value: configService,
      child: const MyApp(),
    ),
  );

  // Wire up the preview bridge — no-op on native platforms.
  PreviewBridge.init((rawConfig) {
    configService.applyRawConfig(rawConfig);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/listing': (_) => const ListingScreen(),
      },
    );
  }
}
