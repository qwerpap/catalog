import 'package:catalog/core/shared/widgets/section_title.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_event.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_event.dart';
import 'package:catalog/features/catalog/presentation/widgets/sort_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortSection extends StatelessWidget {
  const SortSection({
    super.key,
    required this.sortType,
  });

  final ProductSortType sortType;

  @override
  Widget build(BuildContext context) {
    final sortOptions = [
      ProductSortType.none,
      ProductSortType.priceAsc,
      ProductSortType.priceDesc,
    ];

    final titles = {
      ProductSortType.none: 'Без сортировки',
      ProductSortType.priceAsc: 'Цена: по возрастанию',
      ProductSortType.priceDesc: 'Цена: по убыванию',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Сортировка'),
        const SizedBox(height: 12),
        ...sortOptions.map((option) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: option != sortOptions.last ? 8 : 0,
            ),
            child: SortOptionWidget(
              title: titles[option]!,
              sortType: option,
              isSelected: sortType == option,
              onTap: () {
                context.read<FiltersBloc>().add(
                      FiltersSortTypeChanged(option),
                    );
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}

