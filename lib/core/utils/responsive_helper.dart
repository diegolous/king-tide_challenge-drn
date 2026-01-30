import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class ResponsiveHelper {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final landscape = isLandscape(context);

    if (width >= desktopBreakpoint) {
      return landscape ? 5 : 6;
    } else if (width >= tabletBreakpoint) {
      return landscape ? 3 : 4;
    } else if (width >= mobileBreakpoint) {
      return landscape ? 3 : 3;
    } else {
      return 2;
    }
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 1200;
    } else if (isTablet(context)) {
      return 900;
    } else {
      return double.infinity;
    }
  }

  static EdgeInsets getPagePadding(BuildContext context) {
    final landscape = isLandscape(context);

    if (isDesktop(context)) {
      return EdgeInsets.all(landscape ? AppSpacing.pagePaddingTablet : AppSpacing.pagePaddingDesktop);
    } else if (isTablet(context)) {
      return EdgeInsets.all(landscape ? AppSpacing.pagePaddingMobile : AppSpacing.pagePaddingTablet);
    } else {
      return EdgeInsets.all(landscape ? AppSpacing.xs : AppSpacing.pagePaddingMobile);
    }
  }
}
