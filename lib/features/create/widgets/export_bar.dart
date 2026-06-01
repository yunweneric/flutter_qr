import 'package:flutter/material.dart';

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
        FilledButton.icon(
          onPressed: isBusy ? null : onDownloadPng,
          style: FilledButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: isBusy
              ? SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: scheme.onPrimary,
                  ),
                )
              : const Icon(Icons.download_rounded, size: 17),
          label: const Text('Export PNG'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: isBusy ? null : onSaveConfig,
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: const Icon(Icons.bookmark_outline_rounded, size: 17),
          label: const Text('Save'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: isBusy ? null : onLoadConfig,
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: const Icon(Icons.folder_open_rounded, size: 17),
          label: const Text('Load'),
        ),
      ],
    );
  }
}
