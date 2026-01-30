import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../stores/character_store.dart';

class FilterBottomSheet extends StatelessWidget {
  final CharacterStore store;

  const FilterBottomSheet({
    super.key,
    required this.store,
  });

  static const double _sheetRadius = 20;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey900 : AppColors.white,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(_sheetRadius)),
      ),
      child: SafeArea(
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
                      if (store.hasActiveFilters)
                        TextButton(
                          onPressed: () {
                            store.clearFilters();
                          },
                          child: Text(l10n.clearAll),
                        ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),

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
                        final isSelected = store.selectedSpecies.contains(species);
                        return FilterChip(
                          label: Text(species),
                          selected: isSelected,
                          onSelected: (_) {
                            store.toggleSpeciesFilter(species);
                          },
                          backgroundColor:
                              isDarkMode ? AppColors.grey800 : AppColors.grey100,
                          selectedColor: AppColors.primary.withValues(alpha: 0.2),
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
                        final isSelected = store.selectedGenders.contains(gender);
                        return FilterChip(
                          label: Text(gender),
                          selected: isSelected,
                          onSelected: (_) {
                            store.toggleGenderFilter(gender);
                          },
                          backgroundColor:
                              isDarkMode ? AppColors.grey800 : AppColors.grey100,
                          selectedColor: AppColors.primary.withValues(alpha: 0.2),
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
                        final isSelected = store.selectedStatuses.contains(status);
                        return FilterChip(
                          label: Text(status),
                          selected: isSelected,
                          onSelected: (_) {
                            store.toggleStatusFilter(status);
                          },
                          backgroundColor:
                              isDarkMode ? AppColors.grey800 : AppColors.grey100,
                          selectedColor: AppColors.primary.withValues(alpha: 0.2),
                          checkmarkColor: AppColors.primary,
                        );
                      }).toList(),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
