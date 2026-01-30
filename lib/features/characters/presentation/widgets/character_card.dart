import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../../domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  static const double _cardShadowBlur = 8;
  static const Offset _cardShadowOffset = Offset(0, 2);
  static const double _shadowDarkOpacity = 0.3;
  static const double _shadowLightOpacity = 0.1;
  static const double _favoriteBackgroundOpacity = 0.5;
  static const double _imageBackgroundOpacity = 0.1;
  static const double _imageContainerAspectRatio = 0.75;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? AppColors.grey800 : AppColors.surface;
    final l10n = AppLocalizations.of(context)!;
    final displayName =
        character.name.trim().isEmpty ? l10n.unknownValue : character.name;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(
                alpha: isDarkMode ? _shadowDarkOpacity : _shadowLightOpacity,
              ),
              blurRadius: _cardShadowBlur,
              offset: _cardShadowOffset,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image container
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: _imageBackgroundOpacity,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSpacing.radiusMd),
                    topRight: Radius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Stack(
                  children: [
                    // Character image - Fill entire container
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSpacing.radiusMd),
                          topRight: Radius.circular(AppSpacing.radiusMd),
                        ),
                        child: _buildCharacterImage(),
                      ),
                    ),
                    // Favorite button
                    Positioned(
                      top: AppSpacing.xs,
                      right: AppSpacing.xs,
                      child: GestureDetector(
                        onTap: onFavoriteTap,
                        child: Container(
                          padding: EdgeInsets.all(AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: AppColors.black.withValues(
                              alpha: _favoriteBackgroundOpacity,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            character.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: character.isFavorite
                                ? AppColors.error
                                : AppColors.white,
                            size: AppSpacing.iconSm,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Character info
            Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: AppTypography.bodyLarge.copyWith(
                      color: isDarkMode
                          ? AppColors.grey100
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.xs),
                  // Badges
                  Wrap(
                    spacing: AppSpacing.xxs,
                    runSpacing: AppSpacing.xxs,
                    children: [
                      if (character.status != null)
                        AppBadge(
                          label: character.status!,
                          color: _getStatusColor(character.status!),
                        ),
                      if (character.gender != null)
                        AppBadge(
                          label: character.gender!,
                          color: _getGenderColor(character.gender!),
                        ),
                      if (character.species != null)
                        AppBadge(
                          label: character.species!,
                          color: AppColors.success,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getGenderColor(String gender) {
    switch (gender.toUpperCase()) {
      case 'MALE':
        return AppColors.info;
      case 'FEMALE':
        return AppColors.cardPink;
      default:
        return AppColors.grey500;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'ALIVE':
        return AppColors.success;
      case 'DEAD':
        return AppColors.error;
      case 'UNKNOWN':
        return AppColors.warning;
      default:
        return AppColors.grey500;
    }
  }

  Widget _buildCharacterImage() {
    // Prefer local image path over network URL
    if (character.localImagePath != null &&
        character.localImagePath!.isNotEmpty) {
      final file = File(character.localImagePath!);
      return Image.file(
        file,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          // If local file fails, fall back to network image
          return _buildNetworkImage();
        },
      );
    }

    // Fall back to network image
    return _buildNetworkImage();
  }

  Widget _buildNetworkImage() {
    if (character.imageUrl != null && character.imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: character.imageUrl!,
        width: double.infinity,
        height: double.infinity,
        imageBuilder: (context, imageProvider) {
          return _buildAdaptiveImage(context, imageProvider);
        },
        placeholder: (context, url) => const SizedBox.shrink(),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildAdaptiveImage(
    BuildContext context,
    ImageProvider imageProvider,
  ) {
    // Container aspect ratio is fixed at 0.75 (3:4) based on childAspectRatio in GridView
    return _AdaptiveImage(
      imageProvider: imageProvider,
      containerAspectRatio: _imageContainerAspectRatio,
    );
  }

  Widget _buildPlaceholder() {
    return Icon(
      Icons.person,
      size: AppSpacing.iconXxl,
      color: AppColors.grey400,
    );
  }
}

class _AdaptiveImage extends StatefulWidget {
  final ImageProvider imageProvider;
  final double containerAspectRatio;

  const _AdaptiveImage({
    required this.imageProvider,
    required this.containerAspectRatio,
  });

  @override
  State<_AdaptiveImage> createState() => _AdaptiveImageState();
}

class _AdaptiveImageState extends State<_AdaptiveImage> {
  BoxFit _boxFit = BoxFit.cover;

  @override
  void initState() {
    super.initState();
    _resolveImage();
  }

  @override
  void didUpdateWidget(_AdaptiveImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageProvider != widget.imageProvider) {
      _resolveImage();
    }
  }

  void _resolveImage() {
    final ImageStream stream = widget.imageProvider.resolve(
      const ImageConfiguration(),
    );

    final ImageStreamListener listener = ImageStreamListener((
      ImageInfo info,
      bool synchronousCall,
    ) {
      if (!mounted) return;

      final image = info.image;
      final imageAspectRatio = image.width / image.height;

      setState(() {
        _boxFit = _getAdaptiveBoxFit(
          imageAspectRatio,
          widget.containerAspectRatio,
        );
      });
    });

    stream.addListener(listener);
  }

  BoxFit _getAdaptiveBoxFit(
    double imageAspectRatio,
    double containerAspectRatio,
  ) {
    final ratioDifference = imageAspectRatio / containerAspectRatio;

    // Use fitHeight for very tall portrait images to show more of the character
    if (ratioDifference < 0.8) {
      return BoxFit.fitHeight;
    }

    // Use cover for all other cases (landscape and normal portrait)
    return BoxFit.cover;
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: widget.imageProvider,
      fit: _boxFit,
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
