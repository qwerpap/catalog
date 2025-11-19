import 'package:catalog/core/shared/widgets/animated_tap.dart';
import 'package:catalog/core/theme/app_colors.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final button = ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        disabledBackgroundColor: colorScheme.primary.withOpacity(0.6),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
              ),
            )
          : Text(
              text,
              style: AppTextStyles.inter16s600w.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
    );

    final wrappedButton = SizedBox(
      width: double.infinity,
      child: button,
    );

    if (isLoading) {
      return wrappedButton;
    }

    return AnimatedTap(
      onTap: onPressed,
      pressedColor: Colors.black.withOpacity(0.15),
      child: wrappedButton,
    );
  }
}

