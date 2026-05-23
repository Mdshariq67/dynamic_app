import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui_config.dart';

enum ConfigState { loading, ready, error }

class UiConfigService extends ChangeNotifier {
  static final UiConfigService _instance = UiConfigService._internal();
  factory UiConfigService() => _instance;
  UiConfigService._internal();

  UiConfig _config = UiConfig.defaultConfig();
  ConfigState _state = ConfigState.loading;
  StreamSubscription<DocumentSnapshot>? _subscription;
  Timer? _retryTimer;

  UiConfig get config => _config;
  ConfigState get state => _state;

  static const _cacheKey = 'ui_config_cache';

  Future<void> loadConfig(String appSlug) async {
    final cached = await _loadFromCache();
    if (cached != null) {
      _config = cached;
      _state = ConfigState.ready;
      notifyListeners();
    }
    // Fetch from Firestore in background; do not await
    _fetchFromFirestore(appSlug);
  }

  void listenToChanges(String appSlug) {
    _subscription?.cancel();
    try {
      _subscription = FirebaseFirestore.instance
          .collection('ui_configs')
          .doc(appSlug)
          .snapshots()
          .listen(
        (snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            final updated = UiConfig.fromJson(snapshot.data()!);
            _config = updated;
            _state = ConfigState.ready;
            _saveToCache(updated);
            notifyListeners();
          }
        },
        onError: (_) {},
      );
    } catch (_) {}
  }

  Future<void> _fetchFromFirestore(String appSlug) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('ui_configs')
          .doc(appSlug)
          .get();
      if (doc.exists && doc.data() != null) {
        final fetched = UiConfig.fromJson(doc.data()!);
        _config = fetched;
        _state = ConfigState.ready;
        await _saveToCache(fetched);
        notifyListeners();
      } else {
        _fallbackToDefault();
      }
    } catch (_) {
      _fallbackToDefault();
      _scheduleRetry(appSlug);
    }
  }

  void _fallbackToDefault() {
    if (_state != ConfigState.ready) {
      _config = UiConfig.defaultConfig();
      _state = ConfigState.ready;
      notifyListeners();
    }
  }

  void _scheduleRetry(String appSlug) {
    _retryTimer?.cancel();
    _retryTimer = Timer(const Duration(seconds: 60), () {
      _fetchFromFirestore(appSlug);
    });
  }

  Future<UiConfig?> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_cacheKey);
      if (json != null) {
        return UiConfig.fromJson(jsonDecode(json) as Map<String, dynamic>);
      }
    } catch (_) {}
    return null;
  }

  Future<void> _saveToCache(UiConfig config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(config.toJson()));
    } catch (_) {}
  }

  /// Applies a raw config map received from the preview bridge.
  /// Updates the in-memory config and notifies listeners immediately.
  /// Does NOT write to cache or Firestore — preview only.
  void applyRawConfig(Map<String, dynamic> raw) {
    try {
      _config = UiConfig.fromJson(raw);
      _state = ConfigState.ready;
      notifyListeners();
    } catch (_) {}
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _retryTimer?.cancel();
    super.dispose();
  }
}
