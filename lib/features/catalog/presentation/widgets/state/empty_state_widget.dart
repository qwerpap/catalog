import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.message = 'No products found',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        message,
        style: AppTextStyles.inter16s400w.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

