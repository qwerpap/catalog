import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog_state.dart';
import 'package:catalog/features/catalog/presentation/widgets/empty_products_widget.dart';
import 'package:catalog/features/catalog/presentation/widgets/product_card.dart';
import 'package:catalog/features/global/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: CustomAppBar(title: 'Catalog'),
        ),
        body: BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            if (state is CatalogLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CatalogError) {
              final theme = Theme.of(context);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: AppTextStyles.inter16s400w.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CatalogBloc>().add(
                              const CatalogLoadProducts(),
                            );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is CatalogLoaded) {
              if (state.products.isEmpty) {
                return const EmptyProductsWidget();
              }

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: state.products[index]);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
    );
  }
}

