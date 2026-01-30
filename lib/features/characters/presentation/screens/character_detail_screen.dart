import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../domain/entities/series_info.dart';
import '../../../../domain/usecases/get_series_info.dart';
import '../../domain/entities/character.dart';
import '../widgets/widgets.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  SeriesInfo? _seriesInfo;
  bool _isLoadingSeries = false;

  static const double _portraitHeaderRatio = 0.6;
  static const double _sheetInitialSize = 0.4;
  static const double _sheetMinSize = 0.4;
  static const double _sheetMaxSize = 0.8;
  static const double _dragHandleWidth = 40;
  static const double _dragHandleHeight = 4;
  static const double _sheetShadowBlur = 10;
  static const Offset _sheetShadowOffset = Offset(0, -5);
  static const double _landscapeImageSize = 250;
  static const double _landscapeIconSize = 120;
  static const double _portraitIconSize = 200;
  static const double _placeholderSize = 400;
  static const double _landscapeAspectRatio = 0.5;
  static const double _squareAspectRatio = 1.0;
  static const double _backgroundCircleLargeSize = 300;
  static const double _backgroundCircleSmallSize = 200;
  static const double _backgroundCircleLargeOffset = -100;
  static const double _backgroundCircleSmallTop = 100;
  static const double _backgroundCircleSmallRight = -150;
  static const double _overlayLargeOpacity = 0.1;
  static const double _overlaySmallOpacity = 0.05;
  static const double _sheetShadowOpacity = 0.2;
  static const double _whiteOverlayOpacity = 0.2;
  static const double _iconPlaceholderOpacity = 0.5;

  @override
  void initState() {
    super.initState();
    _loadSeriesInfo();
  }

  Future<void> _loadSeriesInfo() async {
    setState(() {
      _isLoadingSeries = true;
    });

    final getSeriesInfo = sl<GetSeriesInfo>();
    final result = await getSeriesInfo('Futurama');

    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _isLoadingSeries = false;
          });
        }
      },
      (seriesInfo) {
        if (mounted) {
          setState(() {
            _seriesInfo = seriesInfo;
            _isLoadingSeries = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isLandscape = ResponsiveHelper.isLandscape(context);
    final l10n = AppLocalizations.of(context)!;
    final backgroundColor = isDarkMode ? AppColors.grey900 : AppColors.primary;
    final overlayColor = isDarkMode
        ? AppColors.primary.withValues(alpha: _overlayLargeOpacity)
        : Colors.transparent;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLandscape
          ? _buildLandscapeLayout(context, isDarkMode, overlayColor, l10n)
          : _buildPortraitLayout(context, isDarkMode, overlayColor, l10n),
    );
  }

  Widget _buildLandscapeLayout(
    BuildContext context,
    bool isDarkMode,
    Color overlayColor,
    AppLocalizations l10n,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left side - Character image only
        Expanded(child: Container(child: _buildLandscapeImage())),
        // Right side - Detail content (full height, no app bar spacing)
        Expanded(
          child: Container(
            color: isDarkMode ? AppColors.black : AppColors.surface,
            child: _buildDetailContent(context, isDarkMode, l10n),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(
    BuildContext context,
    bool isDarkMode,
    Color overlayColor,
    AppLocalizations l10n,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Fixed background with circles and character image (only top 60% area)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenHeight * _portraitHeaderRatio,
          child: Stack(
            children: [
              // Background circles
              _buildBackgroundCircles(overlayColor),
              // Character image - fills entire area including app bar
              Positioned.fill(
                child: _buildCharacterDisplay(context, isDarkMode),
              ),
            ],
          ),
        ),
        // Draggable bottom sheet with detail content
        DraggableScrollableSheet(
          initialChildSize: _sheetInitialSize,
          minChildSize: _sheetMinSize,
          maxChildSize: _sheetMaxSize,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.black : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.radiusXl),
                  topRight: Radius.circular(AppSpacing.radiusXl),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: _sheetShadowOpacity),
                    blurRadius: _sheetShadowBlur,
                    offset: _sheetShadowOffset,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    margin: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    width: _dragHandleWidth,
                    height: _dragHandleHeight,
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.grey600 : AppColors.grey300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.only(
                        left: AppSpacing.lg,
                        right: AppSpacing.lg,
                        bottom: MediaQuery.of(context).padding.bottom + AppSpacing.lg,
                      ),
                      child: _buildDetailContentBody(context, isDarkMode, l10n),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLandscapeImage() {
    if (widget.character.imageUrl != null && widget.character.imageUrl!.isNotEmpty) {
      return Hero(
        tag: 'character-${widget.character.id}',
        child: CachedNetworkImage(
          imageUrl: widget.character.imageUrl!,
          imageBuilder: (context, imageProvider) {
            return _buildAdaptiveDetailImage(
              imageProvider,
              _landscapeAspectRatio,
            );
          },
          placeholder: (context, url) => const SizedBox(
            width: _placeholderSize,
            height: _placeholderSize,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.white),
            ),
          ),
          errorWidget: (context, url, error) =>
              const Icon(
                Icons.person,
                size: _portraitIconSize,
                color: AppColors.white,
              ),
        ),
      );
    } else {
      return const Icon(
        Icons.person,
        size: _portraitIconSize,
        color: AppColors.white,
      );
    }
  }

  Widget _buildBackgroundCircles(Color overlayColor) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: _backgroundCircleLargeOffset,
            right: _backgroundCircleLargeOffset,
            child: Container(
              width: _backgroundCircleLargeSize,
              height: _backgroundCircleLargeSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: overlayColor.withValues(alpha: _overlayLargeOpacity),
              ),
            ),
          ),
          Positioned(
            top: _backgroundCircleSmallTop,
            right: _backgroundCircleSmallRight,
            child: Container(
              width: _backgroundCircleSmallSize,
              height: _backgroundCircleSmallSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: overlayColor.withValues(alpha: _overlaySmallOpacity),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterDisplay(
    BuildContext context,
    bool isDarkMode, {
    bool isLandscape = false,
  }) {
    return Column(
      mainAxisAlignment: isLandscape
          ? MainAxisAlignment.center
          : MainAxisAlignment.center,
      mainAxisSize: isLandscape ? MainAxisSize.min : MainAxisSize.max,
      children: [
        // Character name (only in landscape)
        if (isLandscape) ...[
          Text(
            widget.character.name,
            textAlign: TextAlign.center,
            style: AppTypography.h4.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Species badge (only in landscape)
          if (widget.character.species != null) ...[
            SizedBox(height: AppSpacing.sm),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: _whiteOverlayOpacity),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Text(
                widget.character.species!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          SizedBox(height: AppSpacing.xl),
        ],
        // Character image
        if (widget.character.imageUrl != null && widget.character.imageUrl!.isNotEmpty)
          if (isLandscape)
            Hero(
              tag: 'character-${widget.character.id}',
              child: SizedBox(
                width: _landscapeImageSize,
                height: _landscapeImageSize,
                child: CachedNetworkImage(
                  imageUrl: widget.character.imageUrl!,
                  imageBuilder: (context, imageProvider) {
                    return _buildAdaptiveDetailImage(
                      imageProvider,
                      _squareAspectRatio,
                    );
                  },
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.person,
                    size: _landscapeIconSize,
                    color: AppColors.white.withValues(alpha: _iconPlaceholderOpacity),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Hero(
                tag: 'character-${widget.character.id}',
                child: CachedNetworkImage(
                  imageUrl: widget.character.imageUrl!,
                  imageBuilder: (context, imageProvider) {
                    return _buildAdaptiveDetailImage(
                      imageProvider,
                      _squareAspectRatio,
                    );
                  },
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.person,
                    size: _portraitIconSize,
                    color: AppColors.white.withValues(alpha: _iconPlaceholderOpacity),
                  ),
                ),
              ),
            )
        else if (isLandscape)
          Icon(
            Icons.person,
            size: _landscapeIconSize,
            color: AppColors.white.withValues(alpha: _iconPlaceholderOpacity),
          )
        else
          Expanded(
            child: Icon(
              Icons.person,
              size: _portraitIconSize,
              color: AppColors.white.withValues(alpha: _iconPlaceholderOpacity),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailContent(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: _buildDetailContentBody(context, isDarkMode, l10n),
    );
  }

  Widget _buildDetailContentBody(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterInfoCard(
          character: widget.character,
          isDarkMode: isDarkMode,
          l10n: l10n,
        ),
        if (widget.character.sayings != null &&
            widget.character.sayings!.isNotEmpty) ...[
          SizedBox(height: AppSpacing.lg),
          CharacterSayingsCard(
            sayings: widget.character.sayings!,
            isDarkMode: isDarkMode,
            l10n: l10n,
          ),
        ],
        if (_seriesInfo != null) ...[
          SizedBox(height: AppSpacing.lg),
          SeriesInfoCard(
            seriesInfo: _seriesInfo!,
            isDarkMode: isDarkMode,
            l10n: l10n,
          ),
        ],
        if (_isLoadingSeries) ...[
          SizedBox(height: AppSpacing.lg),
          const Center(child: CircularProgressIndicator()),
        ],
        SizedBox(
          height: MediaQuery.of(context).padding.bottom + AppSpacing.lg,
        ),
      ],
    );
  }

  Widget _buildAdaptiveDetailImage(
    ImageProvider imageProvider,
    double containerAspectRatio,
  ) {
    return _AdaptiveDetailImage(
      imageProvider: imageProvider,
      containerAspectRatio: containerAspectRatio,
    );
  }
}

class _AdaptiveDetailImage extends StatefulWidget {
  final ImageProvider imageProvider;
  final double containerAspectRatio;

  const _AdaptiveDetailImage({
    required this.imageProvider,
    required this.containerAspectRatio,
  });

  @override
  State<_AdaptiveDetailImage> createState() => _AdaptiveDetailImageState();
}

class _AdaptiveDetailImageState extends State<_AdaptiveDetailImage> {
  BoxFit _boxFit = BoxFit.cover;
  static const double _adaptiveTallThreshold = 0.8;

  @override
  void initState() {
    super.initState();
    _resolveImage();
  }

  @override
  void didUpdateWidget(_AdaptiveDetailImage oldWidget) {
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
    if (ratioDifference < _adaptiveTallThreshold) {
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
