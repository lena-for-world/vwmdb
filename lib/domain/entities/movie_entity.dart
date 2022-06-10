import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Movie extends Equatable {
  @required int movieId;
  @required String title;
  @required String poster;

  Movie({required this.movieId, required this.title, required this.poster});

  @override
  List<Object?> get props => [movieId, title, poster];
}