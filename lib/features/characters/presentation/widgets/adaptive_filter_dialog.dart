import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../stores/character_store.dart';
import 'filter_bottom_sheet.dart';

class AdaptiveFilterDialog {
  static void show(BuildContext context, CharacterStore store) {
    final isLandscape = ResponsiveHelper.isLandscape(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isWeb = kIsWeb;

    // Show dialog for web, desktop, tablets, or landscape mode
    // Show bottom sheet only for phones in portrait mode
    if (isWeb || isDesktop || isTablet || isLandscape) {
      showDialog(
        context: context,
        builder: (context) => _FilterDialog(store: store),
      );
    } else {
      // Show as bottom sheet for portrait mobile phones only
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => FilterBottomSheet(store: store),
      );
    }
  }
}

class _FilterDialog extends StatelessWidget {
  final CharacterStore store;

  const _FilterDialog({required this.store});

  static const double _dialogRadius = 20;
  static const double _dialogMaxWidth = 500;
  static const double _dialogMaxHeight = 600;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_dialogRadius),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: _dialogMaxWidth,
          maxHeight: _dialogMaxHeight,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Observer(
            builder: (_) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.filterCharactersTitle,
                        style: AppTypography.h5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (store.hasActiveFilters)
                            TextButton(
                              onPressed: () {
                                store.clearFilters();
                              },
                              child: Text(l10n.clearAll),
                            ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // Scrollable content
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Species Filter
                          if (store.availableSpecies.isNotEmpty) ...[
                            Text(
                              l10n.species,
                              style: AppTypography.h6.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: store.availableSpecies.map((species) {
                                final isSelected =
                                    store.selectedSpecies.contains(species);
                                return FilterChip(
                                  label: Text(species),
                                  selected: isSelected,
                                  onSelected: (_) {
                                    store.toggleSpeciesFilter(species);
                                  },
                                  backgroundColor: isDarkMode
                                      ? AppColors.grey800
                                      : AppColors.grey100,
                                  selectedColor:
                                      AppColors.primary.withValues(alpha: 0.2),
                                  checkmarkColor: AppColors.primary,
                                );
                              }).toList(),
                            ),
                            SizedBox(height: AppSpacing.lg),
                          ],

                          // Gender Filter
                          if (store.availableGenders.isNotEmpty) ...[
                            Text(
                              l10n.gender,
                              style: AppTypography.h6.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: store.availableGenders.map((gender) {
                                final isSelected =
                                    store.selectedGenders.contains(gender);
                                return FilterChip(
                                  label: Text(gender),
                                  selected: isSelected,
                                  onSelected: (_) {
                                    store.toggleGenderFilter(gender);
                                  },
                                  backgroundColor: isDarkMode
                                      ? AppColors.grey800
                                      : AppColors.grey100,
                                  selectedColor:
                                      AppColors.primary.withValues(alpha: 0.2),
                                  checkmarkColor: AppColors.primary,
                                );
                              }).toList(),
                            ),
                            SizedBox(height: AppSpacing.lg),
                          ],

                          // Status Filter
                          if (store.availableStatuses.isNotEmpty) ...[
                            Text(
                              l10n.status,
                              style: AppTypography.h6.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: store.availableStatuses.map((status) {
                                final isSelected =
                                    store.selectedStatuses.contains(status);
                                return FilterChip(
                                  label: Text(status),
                                  selected: isSelected,
                                  onSelected: (_) {
                                    store.toggleStatusFilter(status);
                                  },
                                  backgroundColor: isDarkMode
                                      ? AppColors.grey800
                                      : AppColors.grey100,
                                  selectedColor:
                                      AppColors.primary.withValues(alpha: 0.2),
                                  checkmarkColor: AppColors.primary,
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
