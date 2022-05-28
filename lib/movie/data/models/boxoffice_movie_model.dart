import 'package:flutter/cupertino.dart';
import 'package:vwmdb/movie/domain/entities/movie_entity.dart';

class BoxofficeMovieModel extends Movie {
  @required String? poster;
  @required String? year;

  BoxofficeMovieModel({required int movieId, required String title, required this.poster, required this.year})
      : super(movieId: movieId, title: title);

  factory BoxofficeMovieModel.fromJson(Map<String, dynamic> movie) {
    return BoxofficeMovieModel(
        movieId: movie['id'],
        title: movie['original_title'],
        poster: movie['poster_path'],
        year: movie['release_date']
    );
  }
}