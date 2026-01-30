import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/config/flavor_config.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../stores/character_store.dart';
import '../widgets/widgets.dart';
import 'character_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> with AutomaticKeepAliveClientMixin {
  late final CharacterStore _store;
  final ScrollController _scrollController = ScrollController();
  String _versionInfo = '';

  static const double _gridSpacing = 12;
  static const double _gridAspectRatio = 0.75;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _store = sl<CharacterStore>();
    _store.loadCharacters();
    _loadVersionInfo();
  }

  Future<void> _loadVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final flavorName = FlavorConfig.instance.name;
    setState(() {
      _versionInfo = 'v${packageInfo.version} - $flavorName';
    });
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
          l10n.appTitle,
          style: AppTypography.h5.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_versionInfo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  _versionInfo,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.white.withValues(alpha: 0.7),
                    fontSize: 10,
                  ),
                ),
              ),
            ),
        ],
        backgroundColor: isDarkMode ? AppColors.grey800 : AppColors.primary,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Search bar with filter and sort buttons
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: AppSearchBar(
                      hintText: l10n.searchCharactersHint,
                      onChanged: (value) => _store.setSearchQuery(value),
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  // Filter button
                  Observer(
                    builder: (_) => SizedBox(
                      height: AppSpacing.buttonHeight,
                      width: AppSpacing.buttonHeight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _store.hasActiveFilters
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.filter_list,
                            color: _store.hasActiveFilters
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                          onPressed: () {
                            AdaptiveFilterDialog.show(context, _store);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs),
                  // Sort button
                  Observer(
                    builder: (_) => SizedBox(
                      height: AppSpacing.buttonHeight,
                      width: AppSpacing.buttonHeight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: IconButton(
                          icon: Icon(
                            _store.sortOption == SortOption.nameAsc
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            _store.toggleSort();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Character list
            Expanded(
              child: Observer(
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

                  if (_store.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: AppSpacing.iconXxl,
                            color: AppColors.error,
                          ),
                          SizedBox(height: AppSpacing.md),
                          Text(
                            l10n.genericErrorMessage,
                            style: AppTypography.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppSpacing.md),
                          ElevatedButton(
                            onPressed: () => _store.loadCharacters(),
                            child: Text(l10n.retry),
                          ),
                        ],
                      ),
                    );
                  }

                  if (_store.filteredCharacters.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.noCharactersFound,
                        style: AppTypography.bodyMedium,
                      ),
                    );
                  }

                  final crossAxisCount = ResponsiveHelper.getGridCrossAxisCount(context);
                  final padding = ResponsiveHelper.getPagePadding(context);
                  final maxWidth = ResponsiveHelper.getMaxContentWidth(context);

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          scrollbars: false,
                        ),
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: padding,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: _gridAspectRatio,
                            crossAxisSpacing: _gridSpacing,
                            mainAxisSpacing: _gridSpacing,
                          ),
                          itemCount: _store.filteredCharacters.length,
                          itemBuilder: (context, index) {
                            final character = _store.filteredCharacters[index];
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
