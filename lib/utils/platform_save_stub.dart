import 'dart:typed_data';

final PlatformSaveImpl platformSave = PlatformSaveStub();

abstract class PlatformSaveImpl {
  Future<void> downloadBytes({
    required Uint8List bytes,
    required String filename,
    required String mimeType,
  });

  Future<void> downloadText({
    required String text,
    required String filename,
    required String mimeType,
  });
}

class PlatformSaveStub implements PlatformSaveImpl {
  @override
  Future<void> downloadBytes({
    required Uint8List bytes,
    required String filename,
    required String mimeType,
  }) async {
    throw UnsupportedError('Download is only supported on web.');
  }

  @override
  Future<void> downloadText({
    required String text,
    required String filename,
    required String mimeType,
  }) async {
    throw UnsupportedError('Download is only supported on web.');
  }
}
