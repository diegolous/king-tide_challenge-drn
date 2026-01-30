import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  // Base URL (set by flavor configuration at runtime)
  static String baseUrl = '';

  static const int defaultLimit = 20;
  static const int maxCachedCharacters = 100;

  // OMDB API
  static const String omdbBaseUrl = 'https://www.omdbapi.com';

  // API key loaded from build-time configuration (--dart-define-from-file)
  static const String omdbApiKey = String.fromEnvironment(
    'OMDB_API_KEY',
    defaultValue: '4287ad07', // Fallback for development
  );

  // CORS proxy for web (allows web browsers to access OMDB API)
  static const String corsProxyUrl = 'https://api.allorigins.win/raw?url=';

  // Construct OMDB series URL
  static String getOmdbSeriesUrl(String seriesTitle) {
    final omdbUrl = '$omdbBaseUrl/?t=$seriesTitle&type=series&apikey=$omdbApiKey';

    // Use CORS proxy for web to bypass CORS restrictions
    if (kIsWeb) {
      return '$corsProxyUrl${Uri.encodeComponent(omdbUrl)}';
    }

    return omdbUrl;
  }
}
