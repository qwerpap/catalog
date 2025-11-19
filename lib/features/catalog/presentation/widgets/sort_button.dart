import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_event.dart';
import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
    required this.currentSortType,
    required this.onSortChanged,
  });

  final ProductSortType currentSortType;
  final ValueChanged<ProductSortType> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopupMenuButton<ProductSortType>(
      icon: Icon(
        Icons.sort,
        color: colorScheme.onSurface,
      ),
      onSelected: onSortChanged,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ProductSortType.none,
          child: Row(
            children: [
              if (currentSortType == ProductSortType.none)
                Icon(
                  Icons.check,
                  size: 20,
                  color: colorScheme.primary,
                )
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              Text(
                'Без сортировки',
                style: AppTextStyles.inter14s400w.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: ProductSortType.priceAsc,
          child: Row(
            children: [
              if (currentSortType == ProductSortType.priceAsc)
                Icon(
                  Icons.check,
                  size: 20,
                  color: colorScheme.primary,
                )
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              Text(
                'Цена: по возрастанию',
                style: AppTextStyles.inter14s400w.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: ProductSortType.priceDesc,
          child: Row(
            children: [
              if (currentSortType == ProductSortType.priceDesc)
                Icon(
                  Icons.check,
                  size: 20,
                  color: colorScheme.primary,
                )
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              Text(
                'Цена: по убыванию',
                style: AppTextStyles.inter14s400w.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

