// Removes the HTML splash screen defined in web/index.html once Flutter is
// ready. Uses a conditional export so non-web builds get a harmless no-op.
export 'web_loader_stub.dart'
    if (dart.library.js_interop) 'web_loader_web.dart';
