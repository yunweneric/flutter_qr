import 'dart:ui';

import 'package:flutter_qr/models/qr_config.dart';
import 'package:flutter_qr/models/qr_decoration_builder.dart';
import 'package:flutter_qr/utils/platform_save.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ExportService {
  Future<void> downloadPng(QrConfig config) async {
    final data = config.data.trim().isEmpty ? ' ' : config.data.trim();
    final qrCode = QrCode.fromData(
      data: data,
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    final qrImage = QrImage(qrCode);
    final decoration = QrDecorationBuilder.build(config);

    final bytes = await qrImage.toImageAsBytes(
      size: config.size,
      format: ImageByteFormat.png,
      decoration: decoration,
    );

    if (bytes == null) {
      throw StateError('Failed to export QR code image.');
    }

    await PlatformSave.downloadBytes(
      bytes: bytes.buffer.asUint8List(),
      filename: 'qr-code.png',
      mimeType: 'image/png',
    );
  }

  Future<void> saveConfig(QrConfig config) async {
    await PlatformSave.downloadText(
      text: config.toJsonString(),
      filename: 'qr-config.json',
      mimeType: 'application/json',
    );
  }
}
