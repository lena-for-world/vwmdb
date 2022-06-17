import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int movieId;
  final String title;
  final String poster;

  Movie({required this.movieId, required this.title, required this.poster});

  @override
  List<Object?> get props => [movieId, title, poster];
}