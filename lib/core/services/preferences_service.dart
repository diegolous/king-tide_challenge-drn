import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing app preferences using SharedPreferences
class PreferencesService {
  static const String _themeKey = 'theme_mode';
  static const String _themeDark = 'dark';
  static const String _themeLight = 'light';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  /// Get the saved theme mode
  /// Returns true if dark mode is enabled, false otherwise
  bool isDarkMode() {
    final theme = _prefs.getString(_themeKey);
    return theme == _themeDark;
  }

  /// Save the theme mode
  Future<bool> setDarkMode(bool isDark) async {
    return await _prefs.setString(_themeKey, isDark ? _themeDark : _themeLight);
  }

  /// Clear all preferences
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
