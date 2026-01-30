import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized typography system for the Futurama Characters app
/// All text styles use flutter_screenutil's adaptive sizing (.r)
/// which automatically adjusts based on screen dimensions and orientation
/// In landscape mode, sizing is based on height to prevent oversized text
/// Based on iPhone 17 Pro Max design size: 430 x 932 dp
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // Font Family
  static const String fontFamily = 'CircularStd';

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight black = FontWeight.w900;

  // Headings
  static TextStyle get h1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 36.r,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle get h2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.r,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle get h3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.r,
    fontWeight: bold,
    height: 1.3,
    letterSpacing: -0.25,
  );

  static TextStyle get h4 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.r,
    fontWeight: bold,
    height: 1.3,
  );

  static TextStyle get h5 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.r,
    fontWeight: bold,
    height: 1.4,
  );

  static TextStyle get h6 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.r,
    fontWeight: bold,
    height: 1.4,
  );

  // Body Text
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.r,
    fontWeight: regular,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.r,
    fontWeight: regular,
    height: 1.5,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.r,
    fontWeight: regular,
    height: 1.5,
  );

  // Labels
  static TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.r,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15.r,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.r,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // Caption
  static TextStyle get caption => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.r,
    fontWeight: regular,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // Overline
  static TextStyle get overline => TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.r,
    fontWeight: medium,
    height: 1.6,
    letterSpacing: 1.5,
  );

  // Character-specific styles
  static TextStyle get characterName => TextStyle(
    fontFamily: fontFamily,
    fontSize: 36.r,
    fontWeight: bold,
    height: 1.2,
  );

  static TextStyle get characterId => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.r,
    fontWeight: bold,
    height: 1.2,
  );

  static TextStyle get characterType => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.r,
    fontWeight: medium,
    height: 1.2,
  );

  static TextStyle get statName => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15.r,
    fontWeight: medium,
    height: 1.3,
  );

  static TextStyle get statValue => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.r,
    fontWeight: bold,
    height: 1.2,
  );
}
