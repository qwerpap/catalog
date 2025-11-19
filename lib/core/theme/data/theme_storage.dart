import 'package:catalog/core/services/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme_mode.dart';

class ThemeStorage {
  ThemeStorage(this._prefs);

  final SharedPreferences _prefs;
  static const String _themeKey = 'app_theme_mode';

  Future<AppThemeMode> getTheme() async {
    try {
      final themeString = _prefs.getString(_themeKey);
      if (themeString == null) {
        return AppThemeMode.dark;
      }
      return AppThemeMode.values.firstWhere(
        (mode) => mode.toString() == themeString,
        orElse: () => AppThemeMode.dark,
      );
    } catch (e, st) {
      Logger.error('Failed to load theme', error: e, stackTrace: st);
      return AppThemeMode.dark;
    }
  }

  Future<void> saveTheme(AppThemeMode themeMode) async {
    try {
      await _prefs.setString(_themeKey, themeMode.toString());
      Logger.info('Theme saved: $themeMode');
    } catch (e, st) {
      Logger.error('Failed to save theme', error: e, stackTrace: st);
    }
  }
}

