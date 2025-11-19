import 'package:catalog/core/shared/widgets/section_title.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_event.dart';
import 'package:catalog/features/catalog/presentation/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  final List<String> categories;
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Категория'),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              final isLast = index == categories.length;
              if (index == 0) {
                final isAllSelected = selectedCategory == null;
                return Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 8),
                  child: FilterChipWidget(
                    label: 'Все',
                    isSelected: isAllSelected,
                    onSelected: (selected) {
                      context.read<FiltersBloc>().add(
                            const FiltersCategoryChanged(null),
                          );
                    },
                  ),
                );
              }
              final category = categories[index - 1];
              final isCategorySelected = selectedCategory == category;
              return Padding(
                padding: EdgeInsets.only(right: isLast ? 0 : 8),
                child: FilterChipWidget(
                  label: category,
                  isSelected: isCategorySelected,
                  onSelected: (selected) {
                    context.read<FiltersBloc>().add(
                          FiltersCategoryChanged(
                            isCategorySelected ? null : category,
                          ),
                        );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

