import 'dart:typed_data';

import 'platform_save_stub.dart'
    if (dart.library.js_interop) 'platform_save_web.dart';

abstract class PlatformSave {
  static Future<void> downloadBytes({
    required Uint8List bytes,
    required String filename,
    required String mimeType,
  }) {
    return platformSave.downloadBytes(
      bytes: bytes,
      filename: filename,
      mimeType: mimeType,
    );
  }

  static Future<void> downloadText({
    required String text,
    required String filename,
    required String mimeType,
  }) {
    return platformSave.downloadText(
      text: text,
      filename: filename,
      mimeType: mimeType,
    );
  }
}
