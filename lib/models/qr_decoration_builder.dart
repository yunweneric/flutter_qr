import 'package:flutter/material.dart';
import 'package:flutter_qr/models/qr_config.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrDecorationBuilder {
  static PrettyQrDecoration build(QrConfig config) {
    return PrettyQrDecoration(
      background: config.backgroundColor,
      quietZone: PrettyQrQuietZone.modules(config.quietZone),
      shape: PrettyQrShape.custom(
        _moduleShape(config.moduleShape, config.dotsColor),
        finderPattern: _cornerShape(
          config.cornerSquareShape,
          config.cornerSquareColor,
        ),
        alignmentPatterns: _cornerShape(
          config.cornerDotShape,
          config.cornerDotColor,
        ),
      ),
      image: _buildImage(config),
    );
  }

  static PrettyQrDecorationImage? _buildImage(QrConfig config) {
    ImageProvider? provider;
    if (config.logoBytes != null) {
      provider = MemoryImage(config.logoBytes!);
    } else if (config.logoUrl != null && config.logoUrl!.isNotEmpty) {
      provider = NetworkImage(config.logoUrl!);
    }

    if (provider == null) {
      return null;
    }

    return PrettyQrDecorationImage(
      image: provider,
      scale: config.logoScale,
      position: PrettyQrDecorationImagePosition.embedded,
    );
  }

  static PrettyQrShape _moduleShape(ModuleShape shape, Color color) {
    return switch (shape) {
      ModuleShape.dots => PrettyQrDotsSymbol(color: color),
      ModuleShape.smooth => PrettyQrSmoothSymbol(color: color, roundFactor: 1),
      ModuleShape.squares => PrettyQrSquaresSymbol(color: color, rounding: 0),
      ModuleShape.extraRounded => PrettyQrSmoothSymbol(
        color: color,
        roundFactor: 1,
      ),
    };
  }

  static PrettyQrShape _cornerShape(CornerShape shape, Color color) {
    return switch (shape) {
      CornerShape.dot => PrettyQrDotsSymbol(color: color),
      CornerShape.square => PrettyQrSquaresSymbol(color: color, rounding: 0),
      CornerShape.extraRounded => PrettyQrSmoothSymbol(
        color: color,
        roundFactor: 1,
      ),
    };
  }
}
