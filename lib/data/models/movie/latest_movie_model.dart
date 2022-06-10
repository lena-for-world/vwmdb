import 'package:flutter/cupertino.dart';

import '../../../domain/entities/movie_entity.dart';

class LatestMovieModel extends Movie {
  @required String? year;

  LatestMovieModel({required int movieId, required String title, required String poster, required this.year})
      : super(movieId: movieId, title: title, poster: poster);

  factory LatestMovieModel.fromJson(Map<String, dynamic> movie) {
    return LatestMovieModel(
        movieId: movie['id'],
        title: movie['original_title'],
        poster: movie['poster_path'],
        year: movie['release_date'],
    );
  }
}