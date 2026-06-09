import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/data/presets.dart';
import 'package:flutter_qr/features/create/widgets/ui_kit.dart';
import 'package:flutter_qr/models/qr_config.dart';
import 'package:hugeicons/hugeicons.dart';

class StylePanel extends StatelessWidget {
  const StylePanel({
    super.key,
    required this.config,
    required this.selectedPreset,
    required this.dataController,
    required this.logoUrlController,
    required this.onChanged,
    required this.onDataChanged,
    required this.onPresetSelected,
    required this.onLogoPicked,
    required this.onClearLogo,
  });

  final QrConfig config;
  final String selectedPreset;
  final TextEditingController dataController;
  final TextEditingController logoUrlController;
  final ValueChanged<QrConfig> onChanged;
  final ValueChanged<String> onDataChanged;
  final ValueChanged<String> onPresetSelected;
  final ValueChanged<PlatformFile> onLogoPicked;
  final VoidCallback onClearLogo;

  bool get _hasLogo => config.logoBytes != null || config.logoUrl != null;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Content ──────────────────────────────────────────────
            const SectionHeader(
              icon: HugeIcons.strokeRoundedNoteEdit,
              title: 'Content',
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dataController,
              maxLines: 1,
              onChanged: onDataChanged,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                hintText: 'Enter a URL, text, or other data…',
                prefixIcon: HugeIcon(icon: HugeIcons.strokeRoundedTag01, size: 17),
                prefixIconConstraints: BoxConstraints(minWidth: 38, minHeight: 0),
              ),
            ),
            const SizedBox(height: 10),
            const FieldLabel('Preset'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final preset in qrPresets)
                  PresetChip(
                    label: preset.name,
                    selected: preset.name == selectedPreset,
                    onTap: () => onPresetSelected(preset.name),
                  ),
              ],
            ),

            const _Gap(),

            // ── Colors ───────────────────────────────────────────────
            const SectionHeader(
              icon: HugeIcons.strokeRoundedColorPicker,
              title: 'Colors',
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwatchTile(
                    label: 'Background',
                    color: config.backgroundColor,
                    onTap: () => _pickColor(
                      context,
                      config.backgroundColor,
                      (c) => onChanged(config.copyWith(backgroundColor: c)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SwatchTile(
                    label: 'Dots',
                    color: config.dotsColor,
                    onTap: () => _pickColor(
                      context,
                      config.dotsColor,
                      (c) => onChanged(config.copyWith(dotsColor: c)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwatchTile(
                    label: 'Corner square',
                    color: config.cornerSquareColor,
                    onTap: () => _pickColor(
                      context,
                      config.cornerSquareColor,
                      (c) => onChanged(config.copyWith(cornerSquareColor: c)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SwatchTile(
                    label: 'Corner dot',
                    color: config.cornerDotColor,
                    onTap: () => _pickColor(
                      context,
                      config.cornerDotColor,
                      (c) => onChanged(config.copyWith(cornerDotColor: c)),
                    ),
                  ),
                ),
              ],
            ),

            const _Gap(),

            // ── Shape ────────────────────────────────────────────────
            const SectionHeader(icon: HugeIcons.strokeRoundedShapes01, title: 'Shape'),
            const SizedBox(height: 10),
            const FieldLabel('Dots'),
            const SizedBox(height: 7),
            SegmentControl<ModuleShape>(
              values: ModuleShape.values,
              selected: config.moduleShape,
              labelOf: _moduleLabel,
              onChanged: (v) => onChanged(config.copyWith(moduleShape: v)),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const FieldLabel('Corner square'),
                      const SizedBox(height: 7),
                      SegmentControl<CornerShape>(
                        values: CornerShape.values,
                        selected: config.cornerSquareShape,
                        labelOf: _cornerLabel,
                        onChanged: (v) =>
                            onChanged(config.copyWith(cornerSquareShape: v)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const FieldLabel('Corner dot'),
                      const SizedBox(height: 7),
                      SegmentControl<CornerShape>(
                        values: CornerShape.values,
                        selected: config.cornerDotShape,
                        labelOf: _cornerLabel,
                        onChanged: (v) => onChanged(config.copyWith(cornerDotShape: v)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const _Gap(),

            // ── Layout ───────────────────────────────────────────────
            const SectionHeader(
              icon: HugeIcons.strokeRoundedSlidersHorizontal,
              title: 'Layout',
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppSlider(
                    label: 'Output size',
                    value: config.size.toDouble(),
                    min: 180,
                    max: 512,
                    divisions: 16,
                    badge: '${config.size} px',
                    onChanged: (v) => onChanged(config.copyWith(size: v.round())),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: AppSlider(
                    label: 'Quiet zone',
                    value: config.quietZone,
                    min: 0,
                    max: 8,
                    divisions: 8,
                    badge: config.quietZone.toInt().toString(),
                    onChanged: (v) => onChanged(config.copyWith(quietZone: v)),
                  ),
                ),
              ],
            ),

            const _Gap(),

            // ── Logo ─────────────────────────────────────────────────
            SectionHeader(
              icon: HugeIcons.strokeRoundedImage01,
              title: 'Logo',
              trailing: _hasLogo ? _RemoveButton(onTap: onClearLogo) : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: logoUrlController,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Paste image URL',
                      prefixIcon: HugeIcon(icon: HugeIcons.strokeRoundedLink01, size: 17),
                      prefixIconConstraints: BoxConstraints(minWidth: 38, minHeight: 0),
                    ),
                    onChanged: (value) => onChanged(
                      config.copyWith(
                        logoUrl: value.isEmpty ? null : value,
                        logoBytes: value.isEmpty ? config.logoBytes : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 44,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        withData: true,
                      );
                      final file = result?.files.first;
                      if (file != null) onLogoPicked(file);
                    },
                    icon: const HugeIcon(icon: HugeIcons.strokeRoundedUpload01, size: 16),
                    label: const Text('Upload'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                ),
              ],
            ),
            if (_hasLogo) ...[
              const SizedBox(height: 10),
              AppSlider(
                label: 'Logo size',
                value: config.logoScale,
                min: 0.1,
                max: 0.35,
                divisions: 5,
                badge: '${(config.logoScale * 100).round()}%',
                onChanged: (v) => onChanged(config.copyWith(logoScale: v)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickColor(
    BuildContext context,
    Color current,
    ValueChanged<Color> onPicked,
  ) async {
    final picked = await showColorPickerDialog(
      context,
      current,
      pickersEnabled: const {
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      borderRadius: 12,
    );
    onPicked(picked);
  }
}

class _Gap extends StatelessWidget {
  const _Gap();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        height: 1,
        color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.7),
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  const _RemoveButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton.icon(
      onPressed: onTap,
      icon: const HugeIcon(icon: HugeIcons.strokeRoundedCancel01, size: 14),
      label: const Text('Remove'),
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        minimumSize: const Size(0, 28),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
      ),
    );
  }
}

String _moduleLabel(ModuleShape s) => switch (s) {
  ModuleShape.dots => 'Dots',
  ModuleShape.smooth => 'Smooth',
  ModuleShape.squares => 'Square',
  ModuleShape.extraRounded => 'Rounded',
};

String _cornerLabel(CornerShape s) => switch (s) {
  CornerShape.dot => 'Dot',
  CornerShape.square => 'Square',
  CornerShape.extraRounded => 'Rounded',
};
