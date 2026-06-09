import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ExportBar extends StatelessWidget {
  const ExportBar({
    super.key,
    required this.onDownloadPng,
    required this.onSaveConfig,
    required this.onLoadConfig,
    this.isBusy = false,
  });

  final VoidCallback onDownloadPng;
  final VoidCallback onSaveConfig;
  final VoidCallback onLoadConfig;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 46,
            child: FilledButton.icon(
              onPressed: isBusy ? null : onDownloadPng,
              icon: isBusy
                  ? SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: scheme.onPrimary,
                      ),
                    )
                  : const HugeIcon(icon: HugeIcons.strokeRoundedDownload01, size: 17),
              label: Text(isBusy ? 'Working…' : 'Export PNG'),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 46,
            child: OutlinedButton.icon(
              onPressed: isBusy ? null : onSaveConfig,
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedBookmark01, size: 16),
              label: const Text('Save'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 46,
            child: OutlinedButton.icon(
              onPressed: isBusy ? null : onLoadConfig,
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedFolderOpen, size: 16),
              label: const Text('Load'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
