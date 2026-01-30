/// Futurama Characters Design System
///
/// A comprehensive design system package for the Futurama Characters application.
/// This package provides a centralized way to manage colors, typography,
/// spacing, theming, and UI components across the entire application.
///
/// ## Features
/// - Centralized color palette
/// - Typography system with predefined text styles
/// - Spacing system based on 4px grid with flutter_screenutil
/// - Complete Material 3 theme configuration
/// - Atomic Design components (Atoms, Molecules, Organisms)
///
/// ## Usage
///
/// Import the design system:
/// ```dart
/// import 'package:design_system/design_system.dart';
/// ```
///
/// Use colors:
/// ```dart
/// Container(
///   color: AppColors.primary,
///   child: Text(
///     'Hello',
///     style: TextStyle(color: AppColors.textOnPrimary),
///   ),
/// )
/// ```
///
/// Use typography:
/// ```dart
/// Text('Title', style: AppTypography.h5)
/// Text('Body', style: AppTypography.bodyMedium)
/// ```
///
/// Use spacing:
/// ```dart
/// Padding(padding: EdgeInsets.all(AppSpacing.md))
/// SizedBox(height: AppSpacing.xl)
/// BorderRadius.circular(AppSpacing.radiusMd)
/// ```
///
/// Use atomic components:
/// ```dart
/// // Organisms
/// LoadingShimmer(itemCount: 10)
/// AnimatedOverlay(animation: animation, color: Colors.black)
/// FabItem(FabItemData('Title', Icons.star))
/// ExpandedAnimationFab(animation: animation, items: fabItems)
/// ```
///
/// Apply theme:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   home: MyHomePage(),
/// )
/// ```
library;

// Design Tokens
export 'src/app_colors.dart';
export 'src/app_typography.dart';
export 'src/app_spacing.dart';
export 'src/app_theme.dart';

// Utilities
export 'src/utils/responsive_text.dart';

// Atomic Design Components
export 'src/molecules/molecules.dart';
export 'src/organisms/organisms.dart';
