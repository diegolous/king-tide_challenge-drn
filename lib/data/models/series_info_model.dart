import '../../domain/entities/series_info.dart';

class SeriesInfoModel extends SeriesInfo {
  const SeriesInfoModel({
    required super.title,
    required super.year,
    required super.rated,
    required super.genre,
    required super.plot,
    required super.poster,
    required super.imdbRating,
    required super.imdbID,
    required super.totalSeasons,
  });

  factory SeriesInfoModel.fromJson(Map<String, dynamic> json) {
    return SeriesInfoModel(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      rated: json['Rated'] ?? '',
      genre: json['Genre'] ?? '',
      plot: json['Plot'] ?? '',
      poster: json['Poster'] ?? '',
      imdbRating: json['imdbRating'] ?? 'N/A',
      imdbID: json['imdbID'] ?? '',
      totalSeasons: json['totalSeasons'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Year': year,
      'Rated': rated,
      'Genre': genre,
      'Plot': plot,
      'Poster': poster,
      'imdbRating': imdbRating,
      'imdbID': imdbID,
      'totalSeasons': totalSeasons,
    };
  }
}
