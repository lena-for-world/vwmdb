import 'package:vwmdb/core/network/poster.dart';

import '../../../domain/entities/movie_entity.dart';

class SearchedMovieModel extends Movie {
  SearchedMovieModel({required int movieId, required String title, required String poster})
      : super(movieId: movieId, title: title, poster: poster);

  factory SearchedMovieModel.fromJson(Map<String, dynamic> movie) {
    return SearchedMovieModel(
        movieId: movie['id'] ?? null,
        title: movie['original_title'] ?? '제목이 없습니다',
        poster: movie['poster_path'] ?? defaultPoster,
    );
  }
}