import 'package:catalog/core/theme/app_colors.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          final isAll = index == 0;
          final category = isAll ? null : categories[index - 1];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                isAll ? 'Все' : category!,
                style: AppTextStyles.inter12s400w.copyWith(
                  color: isSelected
                      ? AppColors.whiteColor
                      : colorScheme.onSurface,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onCategorySelected(selected ? category : null);
              },
              backgroundColor: colorScheme.surface,
              selectedColor: colorScheme.primary,
              checkmarkColor: AppColors.whiteColor,
            ),
          );
        },
      ),
    );
  }
}

