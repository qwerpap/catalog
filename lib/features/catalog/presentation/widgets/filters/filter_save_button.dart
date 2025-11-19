import 'package:catalog/core/shared/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class FilterSaveButton extends StatelessWidget {
  const FilterSaveButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: CustomElevatedButton(onPressed: onPressed, text: 'Применить'),
        ),
      ),
    );
  }
}
