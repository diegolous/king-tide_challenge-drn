import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';

class CharacterSayingsCard extends StatelessWidget {
  final List<String> sayings;
  final bool isDarkMode;
  final AppLocalizations l10n;

  const CharacterSayingsCard({
    super.key,
    required this.sayings,
    required this.isDarkMode,
    required this.l10n,
  });

  static const double _shadowDarkOpacity = 0.3;
  static const double _shadowLightOpacity = 0.1;
  static const double _shadowBlur = 8;
  static const Offset _shadowOffset = Offset(0, 2);

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode ? AppColors.grey800 : AppColors.white;

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: isDarkMode ? _shadowDarkOpacity : _shadowLightOpacity,
            ),
            blurRadius: _shadowBlur,
            offset: _shadowOffset,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.famousSayingsTitle,
            style: AppTypography.h6.copyWith(
              color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          ...sayings.map(
            (saying) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      saying,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isDarkMode
                            ? AppColors.grey300
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
