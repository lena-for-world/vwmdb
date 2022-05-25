import 'package:flutter/cupertino.dart';
import 'package:vwmdb/movie/domain/entities/movie_entity.dart';

class LatestMovieModel extends Movie {
  @required String? poster;
  @required String? year;

  LatestMovieModel({required int movieId, required String title, required this.poster, required this.year}) : super(movieId: movieId, title: title);

  factory LatestMovieModel.fromJson(Map<String, dynamic> json) {
    return LatestMovieModel(
        movieId: json['movieId'],
        title: json['title'],
        poster: json['poster'],
        year: json['year'],
    );
  }
}