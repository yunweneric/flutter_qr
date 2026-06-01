import 'package:flutter/material.dart';
import 'package:flutter_qr/data/presets.dart';
import 'package:flutter_qr/models/qr_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('QrConfig JSON round-trip preserves values', () {
    const original = QrConfig(
      data: 'hello world',
      size: 400,
      backgroundColor: Color(0xFF111111),
      dotsColor: Color(0xFFEEEEEE),
      moduleShape: ModuleShape.smooth,
      cornerSquareShape: CornerShape.square,
      quietZone: 6,
    );

    final restored = QrConfig.fromJsonString(original.toJsonString());

    expect(restored.data, original.data);
    expect(restored.size, original.size);
    expect(restored.backgroundColor, original.backgroundColor);
    expect(restored.dotsColor, original.dotsColor);
    expect(restored.moduleShape, original.moduleShape);
    expect(restored.cornerSquareShape, original.cornerSquareShape);
    expect(restored.quietZone, original.quietZone);
  });

  test('Applying preset keeps user data', () {
    const userData = 'https://example.com';
    final preset = qrPresets.firstWhere((item) => item.name == 'Vercel Dark');
    final merged = preset.config.copyWith(data: userData);

    expect(merged.data, userData);
    expect(merged.backgroundColor, preset.config.backgroundColor);
  });
}
