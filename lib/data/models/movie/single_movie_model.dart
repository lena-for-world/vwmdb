import '../../../domain/entities/movie_entity.dart';

class SingleMovieModel extends Movie {
  String overview;
  String year;
  int runtime;
  double voteAverage;
  int voteCount;
  List<String> genres;

  SingleMovieModel({
    required int movieId,
    required String title,
    required String poster,
    required this.overview,
    required this.year,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
  })
      : super(movieId: movieId, title: title, poster: poster);

  factory SingleMovieModel.fromJson(Map<String, dynamic> json) {
    List<String> genres = [];
    json['genres'].forEach((genre) => {
      genres.add(genre['name'])
    });
    return SingleMovieModel(
      movieId: json['id'],
      title: json['original_title'],
      overview: json['overview'],
      poster: json['poster_path'],
      year: json['release_date'],
      runtime: json['runtime'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      genres: genres,
    );
  }
}