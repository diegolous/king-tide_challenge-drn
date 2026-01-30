import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final TextStyle? textStyle;

  const AppBadge({
    super.key,
    required this.label,
    required this.color,
    this.padding,
    this.radius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          radius ?? AppSpacing.radiusXs,
        ),
      ),
      child: Text(
        label,
        style: textStyle ??
            AppTypography.labelSmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
