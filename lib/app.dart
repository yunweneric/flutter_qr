import 'package:flutter/material.dart';
import 'package:flutter_qr/features/create/create_page.dart';
import 'package:flutter_qr/theme/app_theme.dart';

class MiniQrApp extends StatefulWidget {
  const MiniQrApp({super.key});

  @override
  State<MiniQrApp> createState() => _MiniQrAppState();
}

class _MiniQrAppState extends State<MiniQrApp> {
  ThemeMode _themeMode = ThemeMode.system;

  bool get _isDark {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini QR',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.qr_code_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              const Text('Mini QR'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: _isDark ? 'Switch to light' : 'Switch to dark',
              onPressed: () => setState(() {
                _themeMode =
                    _isDark ? ThemeMode.light : ThemeMode.dark;
              }),
              icon: Icon(
                _isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 20,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: const CreatePage(),
      ),
    );
  }
}
