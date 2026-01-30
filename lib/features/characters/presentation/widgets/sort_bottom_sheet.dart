import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../stores/character_store.dart';

class SortBottomSheet extends StatelessWidget {
  final CharacterStore store;

  const SortBottomSheet({
    super.key,
    required this.store,
  });

  static const double _sheetRadius = 20;

  String _getSortOptionLabel(AppLocalizations l10n, SortOption option) {
    switch (option) {
      case SortOption.nameAsc:
        return l10n.sortNameAsc;
      case SortOption.nameDesc:
        return l10n.sortNameDesc;
    }
  }

  IconData _getSortOptionIcon(SortOption option) {
    switch (option) {
      case SortOption.nameAsc:
        return Icons.arrow_upward;
      case SortOption.nameDesc:
        return Icons.arrow_downward;
    }
  }

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
                  Text(
                    l10n.sortCharacters,
                    style: AppTypography.h5.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // Sort options
                  ...SortOption.values.map((option) {
                    final isSelected = store.sortOption == option;
                    return ListTile(
                      leading: Icon(
                        _getSortOptionIcon(option),
                        color: isSelected
                            ? AppColors.primary
                            : (isDarkMode ? AppColors.grey400 : AppColors.grey600),
                      ),
                      title: Text(
                        _getSortOptionLabel(l10n, option),
                        style: AppTypography.bodyLarge.copyWith(
                          color: isSelected ? AppColors.primary : null,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                            )
                          : null,
                      onTap: () {
                        store.setSortOption(option);
                        Navigator.pop(context);
                      },
                    );
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
