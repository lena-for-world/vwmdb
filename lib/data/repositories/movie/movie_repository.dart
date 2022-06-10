
import '../../datasources/movie/movie_remote_data_source.dart';
import '../../models/movie/boxoffice_movie_model.dart';
import '../../models/movie/latest_movie_model.dart';
import '../../models/movie/single_movie_model.dart';

abstract class MovieRepository {
  Future<List<BoxofficeMovieModel>> getBoxofficeMovies();
  Future<List<LatestMovieModel>> getLatestMovies();
  Future<String> getTrailerUrl(int movieId);
  Future<SingleMovieModel> getSingleMovieDetail(int movieId);
}

class MovieRepositoryImpl implements MovieRepository {

  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl(this.movieRemoteDataSource);

  @override
  Future<List<BoxofficeMovieModel>> getBoxofficeMovies() async {
    return movieRemoteDataSource.getBoxofficeMovies();
  }
  @override
  Future<SingleMovieModel> getSingleMovieDetail(int movieId) async {
    return await movieRemoteDataSource.getSingleMovieDetail(movieId);
  }

  @override
  Future<String> getTrailerUrl(int movieId) {
    return movieRemoteDataSource.getTrailerUrl(movieId);
  }

  @override
  Future<List<LatestMovieModel>> getLatestMovies() {
    return movieRemoteDataSource.getLatestMovies();
  }

}