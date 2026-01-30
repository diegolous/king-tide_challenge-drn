import 'package:equatable/equatable.dart';

class SeriesInfo extends Equatable {
  final String title;
  final String year;
  final String rated;
  final String genre;
  final String plot;
  final String poster;
  final String imdbRating;
  final String imdbID;
  final String totalSeasons;

  const SeriesInfo({
    required this.title,
    required this.year,
    required this.rated,
    required this.genre,
    required this.plot,
    required this.poster,
    required this.imdbRating,
    required this.imdbID,
    required this.totalSeasons,
  });

  @override
  List<Object?> get props => [
        title,
        year,
        rated,
        genre,
        plot,
        poster,
        imdbRating,
        imdbID,
        totalSeasons,
      ];
}
