// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Futurama Characters';

  @override
  String get searchCharactersHint => 'Search characters...';

  @override
  String get filterCharactersTitle => 'Filter Characters';

  @override
  String get clearAll => 'Clear All';

  @override
  String get species => 'Species';

  @override
  String get gender => 'Gender';

  @override
  String get status => 'Status';

  @override
  String get sortCharacters => 'Sort Characters';

  @override
  String get sortNameAsc => 'Name (A-Z)';

  @override
  String get sortNameDesc => 'Name (Z-A)';

  @override
  String get retry => 'Retry';

  @override
  String get genericErrorMessage => 'Something went wrong. Please try again.';

  @override
  String get noCharactersFound => 'No characters found';

  @override
  String get favoriteCharactersTitle => 'Favorite Characters';

  @override
  String get noFavoriteCharactersYet => 'No favorite characters yet';

  @override
  String get favoritesEmptySubtitle =>
      'Tap the heart icon on any character\\nto add them to your favorites';

  @override
  String get characterInformationTitle => 'Character Information';

  @override
  String get nameLabel => 'Name';

  @override
  String get speciesLabel => 'Species';

  @override
  String get genderLabel => 'Gender';

  @override
  String get homePlanetLabel => 'Home Planet';

  @override
  String get occupationLabel => 'Occupation';

  @override
  String get famousSayingsTitle => 'Famous Sayings';

  @override
  String get seriesInformationTitle => 'Series Information';

  @override
  String get titleLabel => 'Title';

  @override
  String get yearLabel => 'Year';

  @override
  String get genreLabel => 'Genre';

  @override
  String get ratingLabel => 'Rating';

  @override
  String get imdbRatingLabel => 'IMDB Rating';

  @override
  String get totalSeasonsLabel => 'Total Seasons';

  @override
  String get plotLabel => 'Plot';

  @override
  String get unknownValue => 'Unknown';
}
