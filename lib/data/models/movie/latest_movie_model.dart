import 'package:vwmdb/core/network/poster.dart';

import '../../../domain/entities/movie_entity.dart';

class LatestMovieModel extends Movie {
  final String? year;

  LatestMovieModel({required int movieId, required String title, required String poster, required this.year})
      : super(movieId: movieId, title: title, poster: poster);

  factory LatestMovieModel.fromJson(Map<String, dynamic> movie) {
    return LatestMovieModel(
        movieId: movie['id'] ?? 0,
        title: movie['original_title'] ?? '제목이 없습니다',
        poster: movie['poster_path'] ?? defaultPoster,
        year: movie['release_date'] ?? 'null',
    );
  }
}