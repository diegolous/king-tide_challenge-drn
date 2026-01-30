import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppSearchBar extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    this.hintText,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Theme-aware colors - match filter/sort buttons
    final backgroundColor = AppColors.primary.withValues(alpha: 0.1);
    final textColor = isDarkMode ? AppColors.grey100 : AppColors.textPrimary;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTypography.bodyMedium.copyWith(color: textColor),
      decoration: InputDecoration(
        hintText: hintText ?? 'Search...',
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textHint,
        ),
        prefixIcon: Icon(Icons.search, color: AppColors.primary),
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}
