import 'package:catalog/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidGlassBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const LiquidGlassBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: safeAreaBottom > 0 ? safeAreaBottom + 8 : 16,
      ),
      child: LiquidGlassLayer(
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
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  index: 0,
                  icon: Icons.store_outlined,
                  activeIcon: Icons.store,
                  label: 'Каталог',
                ),
                _buildNavItem(
                  context: context,
                  index: 1,
                  icon: Icons.shopping_cart_outlined,
                  activeIcon: Icons.shopping_cart,
                  label: 'Корзина',
                ),
                _buildNavItem(
                  context: context,
                  index: 2,
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Профиль',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelected = currentIndex == index;
    
    final activeColor = isDark ? AppColors.whiteColor : AppColors.blackColor;
    final inactiveColor = isDark
        ? Colors.white.withOpacity(0.6)
        : Colors.black.withOpacity(0.6);
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

