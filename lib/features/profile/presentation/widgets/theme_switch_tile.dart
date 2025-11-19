import 'package:catalog/core/theme/app_colors.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_event.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_state.dart';
import 'package:catalog/core/theme/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(
              state.themeMode == AppThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: colorScheme.primary,
            ),
            title: Text(
              'Тема',
              style: AppTextStyles.inter16s600w.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              state.themeMode == AppThemeMode.dark ? 'Темная' : 'Светлая',
              style: AppTextStyles.inter14s400w.copyWith(
                color: AppColors.inactiveNavColor,
              ),
            ),
            trailing: Switch(
              value: state.themeMode == AppThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeBloc>().add(
                      ThemeChanged(
                        value ? AppThemeMode.dark : AppThemeMode.light,
                      ),
                    );
              },
              activeColor: colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}

