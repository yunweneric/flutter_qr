import 'package:flutter/material.dart';
import 'package:flutter_qr/features/create/create_page.dart';
import 'package:flutter_qr/theme/app_theme.dart';
import 'package:hugeicons/hugeicons.dart';

class FlutterQrApp extends StatefulWidget {
  const FlutterQrApp({super.key});

  @override
  State<FlutterQrApp> createState() => _FlutterQrAppState();
}

class _FlutterQrAppState extends State<FlutterQrApp> {
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
      title: 'Flutter QR',
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
              SizedBox(
                width: 24,
                height: 24,
                child: ColoredBox(
                  color: const Color(0xFF02569B),
                  child: Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedQrCode01,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text('Flutter QR'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: _isDark ? 'Switch to light' : 'Switch to dark',
              onPressed: () => setState(() {
                _themeMode = _isDark ? ThemeMode.light : ThemeMode.dark;
              }),
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutBack,
                transitionBuilder: (child, animation) => RotationTransition(
                  turns: Tween<double>(begin: 0.6, end: 1).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: HugeIcon(
                  icon: _isDark
                      ? HugeIcons.strokeRoundedSun01
                      : HugeIcons.strokeRoundedMoon01,
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
