import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Movie extends Equatable {
  @required int movieId;
  @required String title;

  Movie({required this.movieId, required this.title});

  @override
  List<Object?> get props => [movieId, title];
}