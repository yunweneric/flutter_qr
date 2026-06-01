import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

enum ModuleShape { dots, smooth, squares, extraRounded }

enum CornerShape { dot, square, extraRounded }

class QrConfig {
  const QrConfig({
    this.data = 'https://flutter.dev',
    this.size = 320,
    this.backgroundColor = Colors.white,
    this.dotsColor = Colors.black,
    this.cornerSquareColor = Colors.black,
    this.cornerDotColor = Colors.black,
    this.moduleShape = ModuleShape.dots,
    this.cornerSquareShape = CornerShape.extraRounded,
    this.cornerDotShape = CornerShape.dot,
    this.quietZone = 4,
    this.logoScale = 0.2,
    this.logoBytes,
    this.logoUrl,
  });

  final String data;
  final int size;
  final Color backgroundColor;
  final Color dotsColor;
  final Color cornerSquareColor;
  final Color cornerDotColor;
  final ModuleShape moduleShape;
  final CornerShape cornerSquareShape;
  final CornerShape cornerDotShape;
  final double quietZone;
  final double logoScale;
  final Uint8List? logoBytes;
  final String? logoUrl;

  QrConfig copyWith({
    String? data,
    int? size,
    Color? backgroundColor,
    Color? dotsColor,
    Color? cornerSquareColor,
    Color? cornerDotColor,
    ModuleShape? moduleShape,
    CornerShape? cornerSquareShape,
    CornerShape? cornerDotShape,
    double? quietZone,
    double? logoScale,
    Uint8List? logoBytes,
    String? logoUrl,
    bool clearLogo = false,
  }) {
    return QrConfig(
      data: data ?? this.data,
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      dotsColor: dotsColor ?? this.dotsColor,
      cornerSquareColor: cornerSquareColor ?? this.cornerSquareColor,
      cornerDotColor: cornerDotColor ?? this.cornerDotColor,
      moduleShape: moduleShape ?? this.moduleShape,
      cornerSquareShape: cornerSquareShape ?? this.cornerSquareShape,
      cornerDotShape: cornerDotShape ?? this.cornerDotShape,
      quietZone: quietZone ?? this.quietZone,
      logoScale: logoScale ?? this.logoScale,
      logoBytes: clearLogo ? null : (logoBytes ?? this.logoBytes),
      logoUrl: clearLogo ? null : (logoUrl ?? this.logoUrl),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'size': size,
      'backgroundColor': backgroundColor.toARGB32(),
      'dotsColor': dotsColor.toARGB32(),
      'cornerSquareColor': cornerSquareColor.toARGB32(),
      'cornerDotColor': cornerDotColor.toARGB32(),
      'moduleShape': moduleShape.name,
      'cornerSquareShape': cornerSquareShape.name,
      'cornerDotShape': cornerDotShape.name,
      'quietZone': quietZone,
      'logoScale': logoScale,
      'logoUrl': logoUrl,
      if (logoBytes != null) 'logoBytes': base64Encode(logoBytes!),
    };
  }

  factory QrConfig.fromJson(Map<String, dynamic> json) {
    return QrConfig(
      data: json['data'] as String? ?? 'https://flutter.dev',
      size: json['size'] as int? ?? 320,
      backgroundColor: Color(json['backgroundColor'] as int? ?? 0xFFFFFFFF),
      dotsColor: Color(json['dotsColor'] as int? ?? 0xFF000000),
      cornerSquareColor: Color(json['cornerSquareColor'] as int? ?? 0xFF000000),
      cornerDotColor: Color(json['cornerDotColor'] as int? ?? 0xFF000000),
      moduleShape: ModuleShape.values.firstWhere(
        (value) => value.name == json['moduleShape'],
        orElse: () => ModuleShape.dots,
      ),
      cornerSquareShape: CornerShape.values.firstWhere(
        (value) => value.name == json['cornerSquareShape'],
        orElse: () => CornerShape.extraRounded,
      ),
      cornerDotShape: CornerShape.values.firstWhere(
        (value) => value.name == json['cornerDotShape'],
        orElse: () => CornerShape.dot,
      ),
      quietZone: (json['quietZone'] as num?)?.toDouble() ?? 4,
      logoScale: (json['logoScale'] as num?)?.toDouble() ?? 0.2,
      logoUrl: json['logoUrl'] as String?,
      logoBytes: json['logoBytes'] != null
          ? base64Decode(json['logoBytes'] as String)
          : null,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  static QrConfig fromJsonString(String source) {
    return QrConfig.fromJson(jsonDecode(source) as Map<String, dynamic>);
  }
}
