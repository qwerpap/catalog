import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class EmptyProductsWidget extends StatelessWidget {
  const EmptyProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Text(
        'No products found',
        style: AppTextStyles.inter16s400w.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

