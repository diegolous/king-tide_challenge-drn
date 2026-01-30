import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized spacing system for the Futurama Characters app
/// All spacing values use flutter_screenutil for responsive sizing
/// Based on iPhone 17 Pro Max design size: 430 x 932 dp
class AppSpacing {
  // Private constructor to prevent instantiation
  AppSpacing._();

  // Base unit: 4px (responsive)
  static double get baseUnit => 4.0.h;

  // Spacing scale (multiples of 4, responsive)
  static double get xxs => 4.h; // 4
  static double get xs => 8.h; // 8
  static double get sm => 12.h; // 12
  static double get md => 16.h; // 16
  static double get lg => 20.h; // 20
  static double get xl => 24.h; // 24
  static double get xxl => 32.h; // 32
  static double get xxxl => 40.h; // 40
  static double get huge => 48.h; // 48
  static double get massive => 64.h; // 64

  // Common spacing aliases for better semantics
  static double get none => 0;
  static double get tiny => xxs; // 4
  static double get small => xs; // 8
  static double get medium => md; // 16
  static double get large => xl; // 24
  static double get extraLarge => xxl; // 32

  // Page padding (responsive)
  static double get pagePaddingMobile => sm; // 12
  static double get pagePaddingTablet => md; // 16
  static double get pagePaddingDesktop => xl; // 24

  // Card spacing
  static double get cardPadding => lg; // 20
  static double get cardMargin => md; // 16
  static double get cardRadius => lg; // 20

  // List spacing
  static double get listItemSpacing => md; // 16
  static double get listItemPadding => md; // 16
  static double get listSectionSpacing => xl; // 24

  // Icon sizes (using .r for maintaining aspect ratio)
  static double get iconXs => 16.r; // 16
  static double get iconSm => 20.r; // 20
  static double get iconMd => 24.r; // 24
  static double get iconLg => 32.r; // 32
  static double get iconXl => 48.r; // 48
  static double get iconXxl => 64.r; // 64

  // Border radius (using .r for maintaining aspect ratio)
  static double get radiusXs => 4.r; // 4
  static double get radiusSm => 8.r; // 8
  static double get radiusMd => 12.r; // 12
  static double get radiusLg => 16.r; // 16
  static double get radiusXl => 20.r; // 20
  static double get radiusXxl => 24.r; // 24
  static double get radiusRound => 48.r; // 48
  static double get radiusCircle => 999; // Circular

  // Character Card specific
  static double get characterCardHeight => 120.h; // 120
  static double get characterCardRadius => radiusXl; // 20
  static double get characterCardPadding => md; // 16
  static double get characterImageSize => 100.r; // 100

  // Character Detail specific
  static double get detailHeaderRadius => radiusXxl; // 24
  static double get detailImageSize => 200.r; // 200
  static double get detailImageSizeDesktop => 250.r; // 250
  static double get detailContentPadding => xl; // 24
  static double get detailSectionSpacing => xxl; // 32

  // Stat bar
  static double get statBarHeight => 10.h; // 10
  static double get statBarRadius => radiusXl; // 20
  static double get statBarSpacing => md; // 16
  static double get statNameWidth => 120.h; // 120
  static double get statValueWidth => 40.h; // 40

  // Evolution card
  static double get evolutionCardWidth => 100.r; // 100

  // Button spacing
  static double get buttonPaddingHorizontal => xl; // 24
  static double get buttonPaddingVertical => sm; // 12
  static double get buttonRadius => radiusMd; // 12
  static double get buttonHeight => huge; // 48

  // Divider
  static double get dividerThickness => 1;
  static double get dividerIndent => md; // 16

  // Elevation/Shadow
  static double get elevationLow => 2;
  static double get elevationMedium => 4;
  static double get elevationHigh => 8;
  static double get elevationVeryHigh => 16;
}
