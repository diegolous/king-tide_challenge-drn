// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Personajes de Futurama';

  @override
  String get searchCharactersHint => 'Buscar personajes...';

  @override
  String get filterCharactersTitle => 'Filtrar personajes';

  @override
  String get clearAll => 'Limpiar todo';

  @override
  String get species => 'Especie';

  @override
  String get gender => 'Género';

  @override
  String get status => 'Estado';

  @override
  String get sortCharacters => 'Ordenar personajes';

  @override
  String get sortNameAsc => 'Nombre (A-Z)';

  @override
  String get sortNameDesc => 'Nombre (Z-A)';

  @override
  String get retry => 'Reintentar';

  @override
  String get genericErrorMessage => 'Algo salió mal. Intenta de nuevo.';

  @override
  String get noCharactersFound => 'No se encontraron personajes';

  @override
  String get favoriteCharactersTitle => 'Personajes favoritos';

  @override
  String get noFavoriteCharactersYet => 'Aún no hay personajes favoritos';

  @override
  String get favoritesEmptySubtitle =>
      'Toca el ícono del corazón en cualquier personaje\\npara añadirlo a tus favoritos';

  @override
  String get characterInformationTitle => 'Información del personaje';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get speciesLabel => 'Especie';

  @override
  String get genderLabel => 'Género';

  @override
  String get homePlanetLabel => 'Planeta natal';

  @override
  String get occupationLabel => 'Ocupación';

  @override
  String get famousSayingsTitle => 'Frases famosas';

  @override
  String get seriesInformationTitle => 'Información de la serie';

  @override
  String get titleLabel => 'Título';

  @override
  String get yearLabel => 'Año';

  @override
  String get genreLabel => 'Género';

  @override
  String get ratingLabel => 'Clasificación';

  @override
  String get imdbRatingLabel => 'Calificación IMDb';

  @override
  String get totalSeasonsLabel => 'Temporadas';

  @override
  String get plotLabel => 'Sinopsis';

  @override
  String get unknownValue => 'Desconocido';
}
