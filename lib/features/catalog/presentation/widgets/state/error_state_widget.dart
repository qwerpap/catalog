import 'package:catalog/core/shared/widgets/custom_elevated_button.dart';
import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTextStyles.inter16s400w.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              CustomElevatedButton(
                onPressed: onRetry!,
                text: 'Retry',
              )
            else
              CustomElevatedButton(
                onPressed: () {
                  context.read<CatalogBloc>().add(
                        const CatalogLoadProducts(),
                      );
                },
                text: 'Retry',
              ),
          ],
        ),
      ),
    );
  }
}

