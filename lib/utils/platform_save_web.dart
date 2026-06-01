import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'platform_save_stub.dart';

final PlatformSaveImpl platformSave = PlatformSaveWeb();

class PlatformSaveWeb implements PlatformSaveImpl {
  @override
  Future<void> downloadBytes({
    required Uint8List bytes,
    required String filename,
    required String mimeType,
  }) async {
    _download(bytes: bytes, filename: filename, mimeType: mimeType);
  }

  @override
  Future<void> downloadText({
    required String text,
    required String filename,
    required String mimeType,
  }) async {
    _download(
      bytes: Uint8List.fromList(utf8.encode(text)),
      filename: filename,
      mimeType: mimeType,
    );
  }

  void _download({
    required Uint8List bytes,
    required String filename,
    required String mimeType,
  }) {
    final blobParts = [bytes.toJS].toJS;
    final blob = web.Blob(blobParts, web.BlobPropertyBag(type: mimeType));
    final url = web.URL.createObjectURL(blob);
    final anchor = web.HTMLAnchorElement()
      ..href = url
      ..download = filename;
    web.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    web.URL.revokeObjectURL(url);
  }
}
