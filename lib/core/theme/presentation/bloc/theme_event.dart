import 'package:equatable/equatable.dart';
import '../../theme_mode.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged(this.themeMode);

  final AppThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

