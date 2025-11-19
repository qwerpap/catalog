import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_state.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_event.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_state.dart';
import 'package:catalog/features/catalog/presentation/widgets/app_bar/filters_app_bar.dart';
import 'package:catalog/features/catalog/presentation/widgets/filters/categories_section.dart';
import 'package:catalog/features/catalog/presentation/widgets/filters/filter_save_button.dart';
import 'package:catalog/features/catalog/presentation/widgets/filters/price_section.dart';
import 'package:catalog/features/catalog/presentation/widgets/filters/sort_section.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/error_state_widget.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late final TextEditingController _minPriceController;
  late final TextEditingController _maxPriceController;

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController();
    _maxPriceController = TextEditingController();

    final filtersState = context.read<FiltersBloc>().state;
    _minPriceController.text = filtersState.minPriceText;
    _maxPriceController.text = filtersState.maxPriceText;
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: FiltersAppBar(
            onClearFilters: () {
              context.read<FiltersBloc>().add(const FiltersClear());
            },
          ),
        ),
        body: BlocConsumer<FiltersBloc, FiltersState>(
          listener: (context, filtersState) {
            if (_minPriceController.text != filtersState.minPriceText) {
              _minPriceController.text = filtersState.minPriceText;
            }
            if (_maxPriceController.text != filtersState.maxPriceText) {
              _maxPriceController.text = filtersState.maxPriceText;
            }
          },
          builder: (context, filtersState) {
            return BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, catalogState) {
                if (catalogState is CatalogLoading) {
                  return const LoadingStateWidget();
                }

                if (catalogState is CatalogError) {
                  return ErrorStateWidget(message: catalogState.message);
                }

                if (catalogState is CatalogLoaded) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CategoriesSection(
                                categories: catalogState.categories,
                                selectedCategory: filtersState.selectedCategory,
                              ),
                              const SizedBox(height: 32),
                              PriceSection(
                                minPriceController: _minPriceController,
                                maxPriceController: _maxPriceController,
                              ),
                              const SizedBox(height: 32),
                              SortSection(sortType: filtersState.sortType),
                            ],
                          ),
                        ),
                      ),
                      FilterSaveButton(
                        onPressed: () {
                          context.read<FiltersBloc>().add(const FiltersApply());
                          context.pop();
                        },
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
