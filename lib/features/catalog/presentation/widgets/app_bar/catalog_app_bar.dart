import 'package:catalog/core/navigation/data/constants/navigation_paths.dart';
import 'package:catalog/core/shared/widgets/custom_app_bar.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_event.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CatalogAppBar extends StatelessWidget {
  const CatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'Catalog',
      actions: [
        BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            if (state is CatalogLoaded) {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.filter_list),
                    if (state.selectedCategory != null ||
                        state.minPrice != null ||
                        state.maxPrice != null ||
                        state.sortType != ProductSortType.none)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  context.push(NavigationPaths.filters);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

