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
      themeAnimationDuration: const Duration(milliseconds: 350),
      themeAnimationCurve: Curves.easeInOut,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.qr_code_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
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
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutBack,
                transitionBuilder: (child, animation) => RotationTransition(
                  turns: Tween<double>(begin: 0.6, end: 1).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: Icon(
                  _isDark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  key: ValueKey(_isDark),
                  size: 18,
                ),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        body: const CreatePage(),
      ),
    );
  }
}
