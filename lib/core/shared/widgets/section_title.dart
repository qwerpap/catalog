import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      title,
      style: AppTextStyles.inter16s600w.copyWith(
        color: colorScheme.onSurface,
      ),
    );
  }
}

