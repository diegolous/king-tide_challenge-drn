import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppInfoRow extends StatelessWidget {
  static const double defaultLabelWidth = 100;

  final String label;
  final String value;
  final double? labelWidth;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const AppInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth,
    this.labelColor,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: labelWidth ?? defaultLabelWidth,
          child: Text(
            label,
            style: labelStyle ??
                AppTypography.bodyMedium.copyWith(
                  color: labelColor ?? AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            value,
            style: valueStyle ?? AppTypography.bodyMedium,
          ),
        ),
      ],
    );
  }
}
