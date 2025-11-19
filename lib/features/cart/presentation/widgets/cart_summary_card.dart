import 'package:catalog/core/shared/widgets/custom_elevated_button.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSummaryCard extends StatelessWidget {
  const CartSummaryCard({
    super.key,
    required this.totalPrice,
    required this.bottomNavHeight,
  });

  final double totalPrice;
  final double bottomNavHeight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: bottomNavHeight,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Итого:',
                    style: AppTextStyles.inter18s600w.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.inter24s600w.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(const CartClear());
                },
                text: 'Очистить корзину',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

