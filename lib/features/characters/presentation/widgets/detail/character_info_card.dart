import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../../../domain/entities/character.dart';

class CharacterInfoCard extends StatelessWidget {
  final Character character;
  final bool isDarkMode;
  final AppLocalizations l10n;

  const CharacterInfoCard({
    super.key,
    required this.character,
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
    final displayName =
        character.name.trim().isEmpty ? l10n.unknownValue : character.name;

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
            l10n.characterInformationTitle,
            style: AppTypography.h6.copyWith(
              color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          AppInfoRow(
            label: l10n.nameLabel,
            value: displayName,
            valueStyle: AppTypography.bodyMedium.copyWith(
              color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
            ),
          ),
          if (character.species != null) ...[
            SizedBox(height: AppSpacing.sm),
            AppInfoRow(
              label: l10n.speciesLabel,
              value: character.species!,
              valueStyle: AppTypography.bodyMedium.copyWith(
                color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
              ),
            ),
          ],
          if (character.gender != null) ...[
            SizedBox(height: AppSpacing.sm),
            AppInfoRow(
              label: l10n.genderLabel,
              value: character.gender!,
              valueStyle: AppTypography.bodyMedium.copyWith(
                color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
              ),
            ),
          ],
          if (character.homePlanet != null) ...[
            SizedBox(height: AppSpacing.sm),
            AppInfoRow(
              label: l10n.homePlanetLabel,
              value: character.homePlanet!,
              valueStyle: AppTypography.bodyMedium.copyWith(
                color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
              ),
            ),
          ],
          if (character.occupation != null) ...[
            SizedBox(height: AppSpacing.sm),
            AppInfoRow(
              label: l10n.occupationLabel,
              value: character.occupation!,
              valueStyle: AppTypography.bodyMedium.copyWith(
                color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
