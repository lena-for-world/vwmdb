import 'package:vwmdb/core/network/poster.dart';

import '../../../domain/entities/movie_entity.dart';

class SingleMovieModel extends Movie {
  final String overview;
  final String year;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;

  SingleMovieModel({
    required int movieId,
    required String title,
    required String poster,
    required this.overview,
    required this.year,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
  })
      : super(movieId: movieId, title: title, poster: poster);

  factory SingleMovieModel.fromJson(Map<String, dynamic> json) {
    List<String> genres = [];
    json['genres'].forEach((genre) => {
      genres.add(genre['name'])
    });
    return SingleMovieModel(
      movieId: json['id'] ?? 0,
      title: json['original_title'],
      overview: json['overview'] ?? 'null',
      poster: json['poster_path'] ?? defaultPoster,
      year: json['release_date'] ?? 'null',
      runtime: json['runtime'] ?? 0,
      voteAverage: json['vote_average'] ?? 0,
      voteCount: json['vote_count'] ?? 0,
      genres: genres ?? [],
    );
  }
}