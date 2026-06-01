import 'package:flutter/material.dart';
import 'package:flutter_qr/models/qr_config.dart';
import 'package:flutter_qr/models/qr_decoration_builder.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrPreview extends StatelessWidget {
  const QrPreview({
    super.key,
    required this.config,
    required this.decoration,
  });

  final QrConfig config;
  final PrettyQrDecoration decoration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = config.data.trim().isEmpty ? ' ' : config.data.trim();
    final qrCode = QrCode.fromData(
      data: data,
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    final qrImage = QrImage(qrCode);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PREVIEW',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${config.size} × ${config.size}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 240),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: SizedBox(
                  key: ValueKey(decoration),
                  width: config.size.toDouble(),
                  height: config.size.toDouble(),
                  child: PrettyQrView(
                    qrImage: qrImage,
                    decoration: decoration,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension QrConfigDecoration on QrConfig {
  PrettyQrDecoration get decoration => QrDecorationBuilder.build(this);
}
