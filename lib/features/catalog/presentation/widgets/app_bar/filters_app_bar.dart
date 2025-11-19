import 'package:catalog/core/shared/widgets/custom_app_bar.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class FiltersAppBar extends StatelessWidget {
  const FiltersAppBar({super.key, required this.onClearFilters});

  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomAppBar(
      title: 'Фильтры',
      actions: [
        TextButton(
          onPressed: onClearFilters,
          child: Text(
            'Сбросить',
            style: AppTextStyles.inter14s400w.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
