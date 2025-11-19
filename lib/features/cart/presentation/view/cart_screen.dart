import 'package:catalog/core/shared/widgets/custom_app_bar.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:catalog/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:catalog/features/cart/presentation/widgets/cart_summary_card.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/empty_state_widget.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/error_state_widget.dart';
import 'package:catalog/features/catalog/presentation/widgets/state/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: const CustomAppBar(title: 'Корзина'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const LoadingStateWidget();
          }

          if (state is CartError) {
            return ErrorStateWidget(message: state.message);
          }

          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return const EmptyStateWidget();
            }

            final safeAreaBottom = MediaQuery.of(context).padding.bottom;
            final bottomNavHeight = 70.0;
            final bottomNavMargin = safeAreaBottom > 0 ? safeAreaBottom + 8 : 16.0;
            final totalBottomNavHeight = bottomNavHeight + bottomNavMargin;

            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: totalBottomNavHeight + 120,
                        ),
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Dismissible(
                            key: ValueKey<int>(item.product.id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              context.read<CartBloc>().add(
                                    CartRemoveItem(item.product.id),
                                  );
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            child: CartItemWidget(item: item),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: totalBottomNavHeight + 120,
                      color: colorScheme.surface,
                    ),
                  ],
                ),
                CartSummaryCard(
                  totalPrice: state.totalPrice,
                  bottomNavHeight: totalBottomNavHeight,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

