import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog/core/navigation/data/constants/navigation_paths.dart';
import 'package:catalog/core/shared/widgets/animated_tap.dart';
import 'package:catalog/core/theme/app_colors.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:catalog/features/cart/domain/entities/cart_item.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:catalog/features/cart/presentation/widgets/cart_card.dart';
import 'package:catalog/features/catalog/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return CartCard(
      child: Row(
          children: [
            InkWell(
              onTap: () {
                final productJson = ProductModel.fromEntity(item.product).toJson();
                context.push(
                  NavigationPaths.productDetailsPath(item.product.id),
                  extra: productJson,
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: theme.scaffoldBackgroundColor,
                  child: CachedNetworkImage(
                    imageUrl: item.product.image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      color: theme.scaffoldBackgroundColor,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: theme.scaffoldBackgroundColor,
                      child: Icon(
                        Icons.error_outline,
                        color: AppColors.inactiveNavColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: AppTextStyles.inter16s600w.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.inter14s400w.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      AnimatedTap(
                        onTap: () {
                          if (item.quantity > 1) {
                            context.read<CartBloc>().add(
                                  CartUpdateQuantity(
                                    productId: item.product.id,
                                    quantity: item.quantity - 1,
                                  ),
                                );
                          } else {
                            context.read<CartBloc>().add(
                                  CartRemoveItem(item.product.id),
                                );
                          }
                        },
                        child: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: null,
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.quantity.toString(),
                        style: AppTextStyles.inter16s600w.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedTap(
                        onTap: () {
                          context.read<CartBloc>().add(
                                CartUpdateQuantity(
                                  productId: item.product.id,
                                  quantity: item.quantity + 1,
                                ),
                              );
                        },
                        child: IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: null,
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.inter16s600w.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedTap(
              onTap: () {
                context.read<CartBloc>().add(
                      CartRemoveItem(item.product.id),
                    );
              },
              child: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: null,
                color: AppColors.inactiveNavColor,
              ),
            ),
          ],
        ),
    );
  }
}

