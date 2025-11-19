import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_event.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_state.dart';
import 'package:catalog/features/catalog/presentation/widgets/app_bar/catalog_app_bar.dart';
import 'package:catalog/features/catalog/presentation/widgets/catalog_search_bar.dart';
import 'package:catalog/features/catalog/presentation/widgets/product_card.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/empty_state_widget.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/error_state_widget.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: const CatalogAppBar(),
        ),
        body: BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            if (state is CatalogLoading) {
              return const LoadingStateWidget();
            }

            if (state is CatalogError) {
              return ErrorStateWidget(message: state.message);
            }

            if (state is CatalogLoaded) {
              final filteredProducts = state.filteredAndSortedProducts;

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CatalogBloc>().add(
                    state.selectedCategory != null
                        ? CatalogLoadProductsByCategory(state.selectedCategory!)
                        : const CatalogLoadProducts(),
                  );
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: CatalogSearchBar(
                          onSearchChanged: (query) {
                            context.read<CatalogBloc>().add(
                              CatalogSearchProducts(query),
                            );
                          },
                        ),
                      ),
                    ),
                    if (filteredProducts.isEmpty)
                      const SliverFillRemaining(child: EmptyStateWidget())
                    else
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return ProductCard(
                              product: filteredProducts[index],
                            );
                          }, childCount: filteredProducts.length),
                        ),
                      ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
