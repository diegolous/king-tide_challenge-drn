import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../../../../../domain/entities/series_info.dart';

class SeriesInfoCard extends StatelessWidget {
  final SeriesInfo seriesInfo;
  final bool isDarkMode;
  final AppLocalizations l10n;

  const SeriesInfoCard({
    super.key,
    required this.seriesInfo,
    required this.isDarkMode,
    required this.l10n,
  });

  static const double _shadowDarkOpacity = 0.3;
  static const double _shadowLightOpacity = 0.1;
  static const double _shadowBlur = 8;
  static const Offset _shadowOffset = Offset(0, 2);
  static const double _posterHeight = 200;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode ? AppColors.grey800 : AppColors.white;
    final valueStyle = AppTypography.bodyMedium.copyWith(
      color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
    );

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
            l10n.seriesInformationTitle,
            style: AppTypography.h6.copyWith(
              color: isDarkMode ? AppColors.grey100 : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          if (seriesInfo.poster != 'N/A') ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              child: CachedNetworkImage(
                imageUrl: seriesInfo.poster,
                height: _posterHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: _posterHeight,
                  color: isDarkMode ? AppColors.grey700 : AppColors.grey200,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: _posterHeight,
                  color: isDarkMode ? AppColors.grey700 : AppColors.grey200,
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.md),
          ],
          AppInfoRow(
            label: l10n.titleLabel,
            value: seriesInfo.title,
            valueStyle: valueStyle,
          ),
          SizedBox(height: AppSpacing.sm),
          AppInfoRow(
            label: l10n.yearLabel,
            value: seriesInfo.year,
            valueStyle: valueStyle,
          ),
          SizedBox(height: AppSpacing.sm),
          AppInfoRow(
            label: l10n.genreLabel,
            value: seriesInfo.genre,
            valueStyle: valueStyle,
          ),
          SizedBox(height: AppSpacing.sm),
          AppInfoRow(
            label: l10n.ratingLabel,
            value: seriesInfo.rated,
            valueStyle: valueStyle,
          ),
          SizedBox(height: AppSpacing.sm),
          AppInfoRow(
            label: l10n.imdbRatingLabel,
            value: seriesInfo.imdbRating,
            valueStyle: valueStyle,
          ),
          SizedBox(height: AppSpacing.sm),
          AppInfoRow(
            label: l10n.totalSeasonsLabel,
            value: seriesInfo.totalSeasons,
            valueStyle: valueStyle,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            l10n.plotLabel,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            seriesInfo.plot,
            style: AppTypography.bodyMedium.copyWith(
              color: isDarkMode ? AppColors.grey300 : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
