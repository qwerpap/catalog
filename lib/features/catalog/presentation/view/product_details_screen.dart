import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog/core/shared/widgets/custom_elevated_button.dart';
import 'package:catalog/core/shared/widgets/glass_snack_bar.dart';
import 'package:catalog/core/theme/app_colors.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:catalog/features/cart/domain/entities/cart_item.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:catalog/features/catalog/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Детали товара'),
        backgroundColor: colorScheme.surface,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                height: 300,
                color: theme.scaffoldBackgroundColor,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 300,
                color: theme.scaffoldBackgroundColor,
                child: Icon(
                  Icons.error_outline,
                  color: AppColors.inactiveNavColor,
                  size: 48,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: AppTextStyles.inter14s400w.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.title,
                    style: AppTextStyles.inter24s600w.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.inter28s600w.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Описание',
                    style: AppTextStyles.inter18s600w.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: AppTextStyles.inter16s400w.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (product.rating != null) ...[
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.rating!.rate.toStringAsFixed(1),
                          style: AppTextStyles.inter16s400w.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${product.rating!.count} отзывов)',
                          style: AppTextStyles.inter14s400w.copyWith(
                            color: AppColors.inactiveNavColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 32),
                  SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                CartAddItem(
                                  CartItem(
                                    product: product,
                                    quantity: 1,
                                  ),
                                ),
                              );
                          GlassSnackBar.show(
                            context,
                            'Товар добавлен в корзину',
                          );
                        },
                        text: 'Добавить в корзину',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

