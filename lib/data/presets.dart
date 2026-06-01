import 'package:flutter/material.dart';
import 'package:flutter_qr/models/qr_config.dart';

class QrPreset {
  const QrPreset({required this.name, required this.config});

  final String name;
  final QrConfig config;
}

const defaultPreset = QrPreset(
  name: 'Default',
  config: QrConfig(
    backgroundColor: Colors.white,
    dotsColor: Color(0xFF000000),
    cornerSquareColor: Color(0xFF000000),
    cornerDotColor: Color(0xFF000000),
    moduleShape: ModuleShape.dots,
    cornerSquareShape: CornerShape.extraRounded,
    cornerDotShape: CornerShape.dot,
  ),
);

final qrPresets = <QrPreset>[
  defaultPreset,
  const QrPreset(
    name: 'Vercel Dark',
    config: QrConfig(
      backgroundColor: Color(0xFF000000),
      dotsColor: Color(0xFFFFFFFF),
      cornerSquareColor: Color(0xFFFFFFFF),
      cornerDotColor: Color(0xFF000000),
      moduleShape: ModuleShape.dots,
      cornerSquareShape: CornerShape.extraRounded,
      cornerDotShape: CornerShape.square,
    ),
  ),
  const QrPreset(
    name: 'Vercel Light',
    config: QrConfig(
      backgroundColor: Color(0xFFFFFFFF),
      dotsColor: Color(0xFF000000),
      cornerSquareColor: Color(0xFF000000),
      cornerDotColor: Color(0xFFFFFFFF),
      moduleShape: ModuleShape.dots,
      cornerSquareShape: CornerShape.extraRounded,
      cornerDotShape: CornerShape.square,
    ),
  ),
  const QrPreset(
    name: 'Supabase Green',
    config: QrConfig(
      backgroundColor: Color(0xFF1C1C1C),
      dotsColor: Color(0xFF3ECF8E),
      cornerSquareColor: Color(0xFF3ECF8E),
      cornerDotColor: Color(0xFF1C1C1C),
      moduleShape: ModuleShape.smooth,
      cornerSquareShape: CornerShape.extraRounded,
      cornerDotShape: CornerShape.dot,
    ),
  ),
  const QrPreset(
    name: 'VueJS',
    config: QrConfig(
      backgroundColor: Color(0xFFFFFFFF),
      dotsColor: Color(0xFF42B883),
      cornerSquareColor: Color(0xFF35495E),
      cornerDotColor: Color(0xFF42B883),
      moduleShape: ModuleShape.squares,
      cornerSquareShape: CornerShape.square,
      cornerDotShape: CornerShape.dot,
    ),
  ),
];
