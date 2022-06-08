import 'package:flutter/cupertino.dart';
import 'package:vwmdb/movie/domain/entities/movie_entity.dart';

class SearchedMovieModel extends Movie {
  SearchedMovieModel({required int movieId, required String title, required String poster})
      : super(movieId: movieId, title: title, poster: poster);

  factory SearchedMovieModel.fromJson(Map<String, dynamic> movie) {
    return SearchedMovieModel(
        movieId: movie['id'],
        title: movie['original_title'],
        poster: movie['poster_path'],
    );
  }
}