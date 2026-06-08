import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qr/models/qr_config.dart';
import 'package:flutter_qr/models/qr_decoration_builder.dart';
import 'package:flutter_qr/theme/app_theme.dart';
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'LIVE PREVIEW',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 10.5,
                  ),
                ),
                const Spacer(),
                _MetaPill(text: '${config.size} × ${config.size}'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final frame = min(
                      min(constraints.maxWidth, constraints.maxHeight),
                      400.0,
                    );
                    return Container(
                      width: frame,
                      height: frame,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.45),
                            theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.18),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppTokens.radiusLg),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        child: DecoratedBox(
                          key: ValueKey(decoration),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PrettyQrView(
                              qrImage: qrImage,
                              decoration: decoration,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              config.data.trim().isEmpty
                  ? 'Empty content'
                  : config.data.trim(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurfaceVariant,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

extension QrConfigDecoration on QrConfig {
  PrettyQrDecoration get decoration => QrDecorationBuilder.build(this);
}
