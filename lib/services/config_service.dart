import 'package:flutter_qr/models/qr_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static const _storageKey = 'mini_qr_config';

  Future<void> save(QrConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, config.toJsonString());
  }

  Future<QrConfig?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) {
      return null;
    }
    return QrConfig.fromJsonString(raw);
  }
}
