import 'package:catalog/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GlassSnackBar extends StatelessWidget {
  const GlassSnackBar({
    super.key,
    required this.message,
  });

  final String message;

  static void show(
    BuildContext context,
    String message,
  ) {
    final overlay = Overlay.of(context);
    final safeAreaTop = MediaQuery.of(context).padding.top;
    
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: safeAreaTop + 52,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: GlassSnackBar(message: message),
        ),
      ),
    );
    
    overlay.insert(overlayEntry);
    
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return LiquidGlassLayer(
      settings: LiquidGlassSettings(
        thickness: 20,
        blur: 10,
        glassColor: isDark
            ? const Color(0x33FFFFFF)
            : const Color(0x33FFFFFF),
        lightIntensity: 1.2,
        ambientStrength: 0.8,
        saturation: 1.2,
        refractiveIndex: 1.5,
      ),
      child: LiquidGlass(
        shape: LiquidRoundedSuperellipse(
          borderRadius: 30,
        ),
        glassContainsChild: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            message,
            style: AppTextStyles.inter14s400w.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

