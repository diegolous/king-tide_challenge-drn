import 'package:flutter/material.dart';

/// Centralized color palette for the Futurama Characters app
/// All colors used throughout the app should be defined here
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF48D0B0);
  static const Color primaryDark = Color(0xFF2FA88A);
  static const Color primaryLight = Color(0xFF6FE0C8);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF9F9F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Grey Scale (for dark mode support)
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Character Type Colors
  static const Color typeNormal = Color(0xFFA8A878);
  static const Color typeFire = Color(0xFFFB6C6C);
  static const Color typeWater = Color(0xFF7AC7FF);
  static const Color typeElectric = Color(0xFFFFCE4B);
  static const Color typeGrass = Color(0xFF78C850);
  static const Color typeIce = Color(0xFF98D8D8);
  static const Color typeFighting = Color(0xFFC03028);
  static const Color typePoison = Color(0xFFA040A0);
  static const Color typeGround = Color(0xFFE0C068);
  static const Color typeFlying = Color(0xFFA890F0);
  static const Color typePsychic = Color(0xFFF85888);
  static const Color typeBug = Color(0xFFA8B820);
  static const Color typeRock = Color(0xFFB8A038);
  static const Color typeGhost = Color(0xFF705898);
  static const Color typeDragon = Color(0xFF7038F8);
  static const Color typeDark = Color(0xFF705848);
  static const Color typeSteel = Color(0xFFB8B8D0);
  static const Color typeFairy = Color(0xFFEE99AC);

  // Card Background Colors (for variety)
  static const Color cardTeal = Color(0xFF48D0B0);
  static const Color cardRed = Color(0xFFFF6E6E);
  static const Color cardBlue = Color(0xFF76B9FF);
  static const Color cardYellow = Color(0xFFF7D866);
  static const Color cardGreen = Color(0xFF78C850);
  static const Color cardPink = Color(0xFFF896D5);
  static const Color cardPurple = Color(0xFFA890F0);
  static const Color cardOrange = Color(0xFFF8A858);

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  static const Color scrim = Color(0x99000000);

  // Divider Colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);

  // Helper method to get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  // Get character type color by type name
  static Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return typeNormal;
      case 'fire':
        return typeFire;
      case 'water':
        return typeWater;
      case 'electric':
        return typeElectric;
      case 'grass':
        return typeGrass;
      case 'ice':
        return typeIce;
      case 'fighting':
        return typeFighting;
      case 'poison':
        return typePoison;
      case 'ground':
        return typeGround;
      case 'flying':
        return typeFlying;
      case 'psychic':
        return typePsychic;
      case 'bug':
        return typeBug;
      case 'rock':
        return typeRock;
      case 'ghost':
        return typeGhost;
      case 'dragon':
        return typeDragon;
      case 'dark':
        return typeDark;
      case 'steel':
        return typeSteel;
      case 'fairy':
        return typeFairy;
      default:
        return typeNormal;
    }
  }

  // Get card color by index (for fallback when type is not available)
  static Color getCardColorByIndex(int index) {
    final colors = [
      cardTeal,
      cardRed,
      cardBlue,
      cardYellow,
      cardGreen,
      cardPink,
      cardPurple,
      cardOrange,
    ];
    return colors[index % colors.length];
  }
}
