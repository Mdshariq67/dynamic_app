import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class PreviewBridge {
  static void init(Function(Map<String, dynamic>) onConfigUpdate) {
    if (!kIsWeb) return;

    void onMessage(web.Event event) {
      try {
        final msg = event as web.MessageEvent;
        final rawData = msg.data.dartify();
        if (rawData == null) return;

        Map<String, dynamic> message;
        if (rawData is String) {
          message = jsonDecode(rawData) as Map<String, dynamic>;
        } else if (rawData is Map) {
          message = Map<String, dynamic>.from(rawData);
        } else {
          return;
        }

        if (message['type'] == 'UI_CONFIG_UPDATE') {
          final config = message['config'];
          if (config != null) {
            onConfigUpdate(Map<String, dynamic>.from(config as Map));
          }
        }
      } catch (e) {
        // ignore: avoid_print
        print('PreviewBridge error: $e');
      }
    }

    web.window.addEventListener('message', onMessage.toJS);

    // Notify the parent frame that Flutter is mounted and ready.
    try {
      web.window.parent?.postMessage(
        jsonEncode({'type': 'FLUTTER_READY'}).toJS,
        '*'.toJS,
      );
    } catch (_) {}
  }
}
