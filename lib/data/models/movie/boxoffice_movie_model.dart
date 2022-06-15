import '../../../domain/entities/movie_entity.dart';

class BoxofficeMovieModel extends Movie {
  final String? year;

  BoxofficeMovieModel({required int movieId, required String title, required String poster, required this.year})
      : super(movieId: movieId, title: title, poster: poster);

  // TODO : null 처리하기
  factory BoxofficeMovieModel.fromJson(Map<String, dynamic> movie) {
    return BoxofficeMovieModel(
        movieId: movie['id'],
        title: movie['original_title'],
        poster: movie['poster_path'],
        year: movie['release_date']
    );
  }
}