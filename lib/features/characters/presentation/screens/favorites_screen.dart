import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../stores/character_store.dart';
import '../widgets/widgets.dart';
import 'character_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with AutomaticKeepAliveClientMixin {
  late final CharacterStore _store;
  final ScrollController _scrollController = ScrollController();

  static const double _gridSpacing = 12;
  static const double _gridAspectRatio = 0.75;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _store = sl<CharacterStore>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.favoriteCharactersTitle,
          style: AppTypography.h5.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkMode ? AppColors.grey800 : AppColors.primary,
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading && _store.characters.isEmpty) {
            final crossAxisCount = ResponsiveHelper.getGridCrossAxisCount(context);
            final padding = ResponsiveHelper.getPagePadding(context);
            final maxWidth = ResponsiveHelper.getMaxContentWidth(context);

            return LoadingShimmer(
              itemCount: 12,
              crossAxisCount: crossAxisCount,
              padding: padding,
              maxWidth: maxWidth,
            );
          }

          if (_store.favoriteCharacters.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: AppSpacing.iconXxl * 2,
                    color: AppColors.grey400,
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.noFavoriteCharactersYet,
                    style: AppTypography.h6.copyWith(
                      color: AppColors.grey400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.favoritesEmptySubtitle,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.grey400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final crossAxisCount = ResponsiveHelper.getGridCrossAxisCount(context);
          final padding = ResponsiveHelper.getPagePadding(context);
          final maxWidth = ResponsiveHelper.getMaxContentWidth(context);

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: GridView.builder(
                controller: _scrollController,
                padding: padding,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: _gridAspectRatio,
                  crossAxisSpacing: _gridSpacing,
                  mainAxisSpacing: _gridSpacing,
                ),
                itemCount: _store.favoriteCharacters.length,
                itemBuilder: (context, index) {
                  final character = _store.favoriteCharacters[index];
                  return CharacterCard(
                    character: character,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailScreen(
                            character: character,
                          ),
                        ),
                      );
                    },
                    onFavoriteTap: () => _store.toggleFavorite(character),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
