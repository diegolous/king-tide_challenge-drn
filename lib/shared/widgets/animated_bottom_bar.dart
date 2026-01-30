import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Animated bottom navigation bar with sliding indicator
class AnimatedBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<IconData> icons;
  final List<IconData> activeIcons;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;

  static const double _barHeight = 60;
  static const double _indicatorHeight = 60;
  static const double _indicatorPadding = 8;
  static const double _indicatorSize = 44;
  static const double _indicatorRadius = 15;
  static const double _shadowBlur = 10;
  static const double _shadowOffsetY = -5;
  static const double _barShadowOpacity = 0.05;
  static const double _indicatorShadowOpacity = 0.3;
  static const double _indicatorShadowBlur = 8;
  static const Offset _indicatorShadowOffset = Offset(0, 2);
  static const double _iconSize = 28;
  static const double _scaleSelected = 1.0;
  static const double _scaleUnselected = 0.85;
  static const Duration _animationDuration = Duration(milliseconds: 300);

  const AnimatedBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
    required this.activeIcons,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemCount = icons.length;
    final itemWidth = screenWidth / itemCount;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final effectiveSelectedColor = selectedColor ?? AppColors.primary;
    final effectiveUnselectedColor = unselectedColor ??
        (isDarkMode ? AppColors.grey400 : AppColors.grey600);
    final effectiveBackgroundColor = backgroundColor ??
        (isDarkMode ? AppColors.grey900 : AppColors.white);

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: _barShadowOpacity),
            blurRadius: _shadowBlur,
            offset: const Offset(0, _shadowOffsetY),
          ),
        ],
      ),
      child: SizedBox(
        height: _barHeight + bottomPadding,
        child: Stack(
          children: [
            // Sliding indicator background
            AnimatedPositioned(
              duration: _animationDuration,
              curve: Curves.easeInOutCubic,
              left: currentIndex * itemWidth,
              child: Container(
                width: itemWidth,
                height: _indicatorHeight,
                padding: const EdgeInsets.symmetric(vertical: _indicatorPadding),
                child: Center(
                  child: Container(
                    width: _indicatorSize,
                    height: _indicatorSize,
                    decoration: BoxDecoration(
                      color: effectiveSelectedColor,
                      borderRadius: BorderRadius.circular(_indicatorRadius),
                      boxShadow: [
                        BoxShadow(
                          color: effectiveSelectedColor.withValues(
                            alpha: _indicatorShadowOpacity,
                          ),
                          blurRadius: _indicatorShadowBlur,
                          offset: _indicatorShadowOffset,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Navigation items
            Row(
              children: List.generate(itemCount, (index) {
                final isSelected = currentIndex == index;
                final icon = isSelected ? activeIcons[index] : icons[index];

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(index),
                    child: Container(
                      height: _barHeight,
                      padding: const EdgeInsets.symmetric(vertical: _indicatorPadding),
                      child: Center(
                        child: AnimatedScale(
                          scale: isSelected ? _scaleSelected : _scaleUnselected,
                          duration: _animationDuration,
                          curve: Curves.easeInOutCubic,
                          child: Icon(
                            icon,
                            size: _iconSize,
                            color: isSelected
                                ? AppColors.white
                                : effectiveUnselectedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
