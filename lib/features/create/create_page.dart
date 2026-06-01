import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr/data/presets.dart';
import 'package:flutter_qr/features/create/widgets/export_bar.dart';
import 'package:flutter_qr/features/create/widgets/qr_preview.dart';
import 'package:flutter_qr/features/create/widgets/style_panel.dart';
import 'package:flutter_qr/models/qr_config.dart';
import 'package:flutter_qr/services/config_service.dart';
import 'package:flutter_qr/services/export_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _exportService = ExportService();
  final _configService = ConfigService();
  late final TextEditingController _dataController;
  late final TextEditingController _logoUrlController;

  QrConfig _config = defaultPreset.config;
  String _previewData = defaultPreset.config.data;
  String _selectedPreset = defaultPreset.name;
  bool _isBusy = false;
  Timer? _dataDebounceTimer;

  @override
  void initState() {
    super.initState();
    _dataController = TextEditingController(text: _config.data);
    _logoUrlController = TextEditingController(text: _config.logoUrl ?? '');
    _previewData = _config.data;
    _restoreSavedConfig();
  }

  Future<void> _restoreSavedConfig() async {
    final saved = await _configService.load();
    if (!mounted || saved == null) return;
    setState(() {
      _config = saved;
      _previewData = saved.data;
      _dataController.text = saved.data;
      _logoUrlController.text = saved.logoUrl ?? '';
    });
  }

  @override
  void dispose() {
    _dataDebounceTimer?.cancel();
    _dataController.dispose();
    _logoUrlController.dispose();
    super.dispose();
  }

  void _updateConfig(QrConfig config) {
    setState(() {
      _config = config;
      _previewData = config.data;
    });
    _configService.save(config);
  }

  void _onDataChanged(String value) {
    final updated = _config.copyWith(data: value);
    setState(() => _config = updated);
    _dataDebounceTimer?.cancel();
    _dataDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _previewData = value);
      _configService.save(updated);
    });
  }

  void _applyPreset(String name) {
    final preset = qrPresets.firstWhere((p) => p.name == name);
    _updateConfig(
      preset.config.copyWith(
        data: _config.data,
        logoBytes: _config.logoBytes,
        logoUrl: _config.logoUrl,
        logoScale: _config.logoScale,
      ),
    );
    setState(() => _selectedPreset = name);
  }

  Future<void> _runExport(Future<void> Function() action) async {
    setState(() => _isBusy = true);
    try {
      await action();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Done'),
          behavior: SnackBarBehavior.floating,
          width: 200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _loadConfigFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    final bytes = result?.files.first.bytes;
    if (bytes == null) return;
    final loaded = QrConfig.fromJsonString(utf8.decode(bytes));
    _dataController.text = loaded.data;
    _logoUrlController.text = loaded.logoUrl ?? '';
    _updateConfig(loaded);
  }

  @override
  Widget build(BuildContext context) {
    final previewConfig = _config.copyWith(data: _previewData);
    final decoration = previewConfig.decoration;

    final preview = QrPreview(config: previewConfig, decoration: decoration);

    final controls = StylePanel(
      config: _config,
      selectedPreset: _selectedPreset,
      dataController: _dataController,
      logoUrlController: _logoUrlController,
      onChanged: _updateConfig,
      onDataChanged: _onDataChanged,
      onPresetSelected: _applyPreset,
      onLogoPicked: (file) {
        final bytes = file.bytes;
        if (bytes == null) return;
        _logoUrlController.clear();
        _updateConfig(
          _config.copyWith(logoBytes: bytes, logoUrl: null, clearLogo: false),
        );
      },
      onClearLogo: () {
        _logoUrlController.clear();
        _updateConfig(_config.copyWith(clearLogo: true));
      },
    );

    final exportBar = ExportBar(
      isBusy: _isBusy,
      onDownloadPng: () =>
          _runExport(() => _exportService.downloadPng(_config)),
      onSaveConfig: () => _runExport(() => _exportService.saveConfig(_config)),
      onLoadConfig: () => _runExport(_loadConfigFromFile),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 768;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: preview + export actions
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      preview,
                      const SizedBox(height: 16),
                      exportBar,
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                width: 1,
                color: Theme.of(context).dividerColor,
              ),
              // Right: style controls
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: controls,
                ),
              ),
            ],
          );
        }

        // Narrow / mobile: single-column scroll
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              preview,
              const SizedBox(height: 16),
              exportBar,
              const SizedBox(height: 24),
              controls,
            ],
          ),
        );
      },
    );
  }
}
