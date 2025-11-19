import 'package:equatable/equatable.dart';
import '../../theme_mode.dart';

class ThemeState extends Equatable {
  const ThemeState(this.themeMode);

  final AppThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

