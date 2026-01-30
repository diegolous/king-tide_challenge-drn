import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../stores/character_store.dart';
import 'sort_bottom_sheet.dart';

class AdaptiveSortDialog {
  static void show(BuildContext context, CharacterStore store) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isWeb = kIsWeb;

    if (isWeb || isLandscape) {
      // Show as dialog for web or landscape
      showDialog(
        context: context,
        builder: (context) => _SortDialog(store: store),
      );
    } else {
      // Show as bottom sheet for portrait mobile
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => SortBottomSheet(store: store),
      );
    }
  }
}

class _SortDialog extends StatelessWidget {
  final CharacterStore store;

  const _SortDialog({required this.store});

  static const double _dialogRadius = 20;
  static const double _dialogMaxWidth = 400;

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

    return Dialog(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_dialogRadius),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _dialogMaxWidth),
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
                        l10n.sortCharacters,
                        style: AppTypography.h5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),

                  // Sort options
                  ...SortOption.values.map((option) {
                    final isSelected = store.sortOption == option;
                    return ListTile(
                      leading: Icon(
                        _getSortOptionIcon(option),
                        color: isSelected
                            ? AppColors.primary
                            : (isDarkMode
                                ? AppColors.grey400
                                : AppColors.grey600),
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
