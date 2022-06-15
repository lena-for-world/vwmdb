import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Movie extends Equatable {
  @required final int movieId;
  @required final String title;
  @required final String poster;

  Movie({required this.movieId, required this.title, required this.poster});

  @override
  List<Object?> get props => [movieId, title, poster];
}