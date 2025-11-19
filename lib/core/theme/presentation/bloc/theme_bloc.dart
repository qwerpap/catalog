import 'package:catalog/core/services/logger.dart';
import 'package:catalog/core/theme/data/theme_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme_mode.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._themeStorage) : super(const ThemeState(AppThemeMode.dark)) {
    on<LoadTheme>(_onLoadTheme);
    on<ThemeChanged>(_onThemeChanged);
    add(const LoadTheme());
  }

  final ThemeStorage _themeStorage;

  Future<void> _onLoadTheme(
    LoadTheme event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final savedTheme = await _themeStorage.getTheme();
      emit(ThemeState(savedTheme));
      Logger.info('Theme loaded: $savedTheme');
    } catch (e, st) {
      Logger.error('Failed to load theme', error: e, stackTrace: st);
      emit(const ThemeState(AppThemeMode.dark));
    }
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      await _themeStorage.saveTheme(event.themeMode);
      emit(ThemeState(event.themeMode));
      Logger.info('Theme changed to: ${event.themeMode}');
    } catch (e, st) {
      Logger.error('Failed to save theme', error: e, stackTrace: st);
    }
  }
}

