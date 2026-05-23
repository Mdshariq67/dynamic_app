// On web: uses package:web + dart:js_interop for window messaging.
// On native: stub that does nothing.
export 'preview_bridge_web.dart'
    if (dart.library.io) 'preview_bridge_stub.dart';
