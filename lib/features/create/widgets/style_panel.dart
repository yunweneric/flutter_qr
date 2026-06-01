import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/data/presets.dart';
import 'package:flutter_qr/models/qr_config.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Content ──────────────────────────────────────────────────
        _Section(
          icon: Icons.edit_note_rounded,
          title: 'Content',
          children: [
            TextField(
              controller: dataController,
              maxLines: 3,
              onChanged: onDataChanged,
              decoration: const InputDecoration(
                hintText: 'Enter a URL, text, or other data…',
              ),
            ),
            const SizedBox(height: 18),
            _Label('Preset'),
            const SizedBox(height: 10),
            _PresetChips(
              selectedPreset: selectedPreset,
              onSelected: onPresetSelected,
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ── Colors ───────────────────────────────────────────────────
        _Section(
          icon: Icons.palette_outlined,
          title: 'Colors',
          children: [
            _ColorRow(
              label: 'Background',
              color: config.backgroundColor,
              onChanged: (c) => onChanged(config.copyWith(backgroundColor: c)),
            ),
            const SizedBox(height: 10),
            _ColorRow(
              label: 'Dots',
              color: config.dotsColor,
              onChanged: (c) => onChanged(config.copyWith(dotsColor: c)),
            ),
            const SizedBox(height: 10),
            _ColorRow(
              label: 'Corner square',
              color: config.cornerSquareColor,
              onChanged: (c) =>
                  onChanged(config.copyWith(cornerSquareColor: c)),
            ),
            const SizedBox(height: 10),
            _ColorRow(
              label: 'Corner dot',
              color: config.cornerDotColor,
              onChanged: (c) => onChanged(config.copyWith(cornerDotColor: c)),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ── Shape ────────────────────────────────────────────────────
        _Section(
          icon: Icons.interests_outlined,
          title: 'Shape',
          children: [
            _Label('Dots'),
            const SizedBox(height: 8),
            _SegmentRow<ModuleShape>(
              values: ModuleShape.values,
              selected: config.moduleShape,
              labelOf: _moduleLabel,
              onChanged: (v) => onChanged(config.copyWith(moduleShape: v)),
            ),
            const SizedBox(height: 16),
            _Label('Corner square'),
            const SizedBox(height: 8),
            _SegmentRow<CornerShape>(
              values: CornerShape.values,
              selected: config.cornerSquareShape,
              labelOf: _cornerLabel,
              onChanged: (v) =>
                  onChanged(config.copyWith(cornerSquareShape: v)),
            ),
            const SizedBox(height: 16),
            _Label('Corner dot'),
            const SizedBox(height: 8),
            _SegmentRow<CornerShape>(
              values: CornerShape.values,
              selected: config.cornerDotShape,
              labelOf: _cornerLabel,
              onChanged: (v) => onChanged(config.copyWith(cornerDotShape: v)),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ── Layout ───────────────────────────────────────────────────
        _Section(
          icon: Icons.straighten_rounded,
          title: 'Layout',
          children: [
            _SliderRow(
              label: 'Output size',
              value: config.size.toDouble(),
              min: 180,
              max: 512,
              divisions: 16,
              badge: '${config.size}px',
              onChanged: (v) => onChanged(config.copyWith(size: v.round())),
            ),
            const SizedBox(height: 4),
            _SliderRow(
              label: 'Quiet zone',
              value: config.quietZone,
              min: 0,
              max: 8,
              divisions: 8,
              badge: config.quietZone.toInt().toString(),
              onChanged: (v) => onChanged(config.copyWith(quietZone: v)),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ── Logo ─────────────────────────────────────────────────────
        _Section(
          icon: Icons.image_outlined,
          title: 'Logo',
          children: [
            TextField(
              controller: logoUrlController,
              decoration: const InputDecoration(
                hintText: 'Image URL (optional)',
                prefixIcon: Icon(Icons.link_rounded, size: 18),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 40, minHeight: 0),
              ),
              onChanged: (value) => onChanged(
                config.copyWith(
                  logoUrl: value.isEmpty ? null : value,
                  logoBytes: value.isEmpty ? config.logoBytes : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                FilledButton.tonalIcon(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      withData: true,
                    );
                    final file = result?.files.first;
                    if (file != null) onLogoPicked(file);
                  },
                  icon: const Icon(Icons.upload_rounded, size: 16),
                  label: const Text('Upload image'),
                ),
                if (config.logoBytes != null || config.logoUrl != null) ...[
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: onClearLogo,
                    icon: const Icon(Icons.close_rounded, size: 16),
                    label: const Text('Remove'),
                  ),
                ],
              ],
            ),
            if (config.logoBytes != null || config.logoUrl != null) ...[
              const SizedBox(height: 12),
              _SliderRow(
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
      ],
    );
  }
}

// ── Helpers ─────────────────────────────────────────────────────────────────

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

// ── Private widgets ──────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon, size: 15, color: theme.colorScheme.primary),
                const SizedBox(width: 7),
                Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}

class _PresetChips extends StatelessWidget {
  const _PresetChips({
    required this.selectedPreset,
    required this.onSelected,
  });

  final String selectedPreset;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final preset in qrPresets)
          _Chip(
            label: preset.name,
            selected: preset.name == selectedPreset,
            onTap: () => onSelected(preset.name),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? theme.colorScheme.primary
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: selected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.label,
    required this.color,
    required this.onChanged,
  });

  final String label;
  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        InkWell(
          onTap: () async {
            final picked = await showColorPickerDialog(
              context,
              color,
              pickersEnabled: const {
                ColorPickerType.primary: true,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.wheel: true,
              },
            );
            onChanged(picked);
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 44,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SegmentRow<T> extends StatelessWidget {
  const _SegmentRow({
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onChanged,
  });

  final List<T> values;
  final T selected;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: [
        for (final v in values)
          ButtonSegment<T>(value: v, label: Text(labelOf(v))),
      ],
      selected: {selected},
      onSelectionChanged: (s) => onChanged(s.first),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.badge,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String badge;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.bodyMedium),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                badge,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
