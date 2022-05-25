import '../../domain/entities/movie_entity.dart';

abstract class MovieRemoteDataSource {
  Future<Movie> getSingleMovieDetail(int);
}