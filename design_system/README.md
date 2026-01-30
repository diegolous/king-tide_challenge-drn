# Futurama Characters Design System

A comprehensive design system package for the Futurama Characters application. This package provides a centralized way to manage colors, typography, spacing, and theming across the entire application.

## Features

- **AppColors**: Centralized color palette with character type colors
- **AppTypography**: Complete typography system with predefined text styles
- **AppSpacing**: Consistent spacing system based on 4px grid with flutter_screenutil
- **AppTheme**: Complete Material 3 theme configuration (light & dark modes)
- **Atomic Design Components**: Reusable UI components

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  design_system:
    path: ../design_system
```

## Usage

```dart
import 'package:design_system/design_system.dart';

// Use colors
Container(
  color: AppColors.primary,
  child: Text(
    'Futurama',
    style: TextStyle(color: AppColors.white),
  ),
)

// Use typography
Text('Title', style: AppTypography.h5)
Text('Body', style: AppTypography.bodyMedium)

// Use spacing
Padding(padding: EdgeInsets.all(AppSpacing.md))
SizedBox(height: AppSpacing.xl)
BorderRadius.circular(AppSpacing.radiusMd)

// Apply theme
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  home: MyHomePage(),
)
```

## Components

### Molecules
- **AppSearchBar**: Search bar with consistent styling

### Organisms
- **LoadingShimmer**: Shimmer loading effect for character cards
- **AnimatedOverlay**: Animated overlay with customizable color
- **FabItem**: Floating action button items
- **ExpandedAnimationFab**: Expandable floating action button

## Design Tokens

### Colors
- Primary colors (Futurama orange theme)
- Surface colors for light/dark mode
- Text colors with proper contrast
- Status colors (success, error, warning, info)
- Character type colors

### Typography
- Heading styles (h1-h6)
- Body text styles (large, medium, small)
- Character-specific styles

### Spacing
- Consistent spacing scale (xs, sm, md, lg, xl, xxl)
- Icon sizes
- Border radius values

## Responsive Design

The design system uses `flutter_screenutil` to ensure consistent sizing across different screen sizes and orientations.

## Theme Support

Full support for light and dark themes with proper color schemes for optimal readability and user experience.
