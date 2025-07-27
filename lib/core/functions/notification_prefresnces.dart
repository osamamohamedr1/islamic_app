import 'package:shared_preferences/shared_preferences.dart';

class NotificationPrefs {
  static const _key = 'notifications_enabled';

  static Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, enabled);
  }

  static Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? true; // default to true (enabled)
  }
}
