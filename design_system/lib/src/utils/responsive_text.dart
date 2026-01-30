import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive text sizing that adapts based on screen orientation
/// Uses height-based scaling when in landscape mode to prevent text from becoming too large
class ResponsiveText {
  ResponsiveText._();

  /// Get responsive font size based on orientation
  /// In landscape mode (width > height), uses height-based scaling
  /// In portrait mode, uses the default adaptive scaling
  static double size(BuildContext context, double designSize) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    if (isLandscape) {
      // Use height-based scaling in landscape
      return designSize.h;
    } else {
      // Use default adaptive scaling in portrait
      return designSize.sp;
    }
  }

  /// Convenience method to get text style with responsive size
  static TextStyle style(
    BuildContext context,
    double designSize, {
    String? fontFamily,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size(context, designSize),
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }
}
