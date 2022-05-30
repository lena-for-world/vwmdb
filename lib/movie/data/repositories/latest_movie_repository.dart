import 'package:vwmdb/movie/data/datasources/latest_movie_remote_sources.dart';

import '../../domain/entities/movie_entity.dart';
import '../datasources/movie_remote_data_source.dart';
import '../models/latest_movie_model.dart';
import 'movie_repository.dart';

abstract class LatestMovieRepository {
  Future<List<dynamic>> getTrailerJson(int movieId);
  Future<List<dynamic>> getLatestMoviesJson();
  List<LatestMovieModel> getLatestMovies(List<dynamic> movieJson);
  String getTrailerUrl(List<dynamic> trailerJson);
}

class LatestMovieRepositoryImpl implements MovieRepository, LatestMovieRepository {
  final LatestMovieRemoteDataSource latestMovieRemoteDataSource;

  LatestMovieRepositoryImpl(this.latestMovieRemoteDataSource);

  @override
  Future<List<dynamic>> getTrailerJson(int movieId) async {
    return await latestMovieRemoteDataSource.getTrailerJson(movieId);
  }

  @override
  Future<List<dynamic>> getLatestMoviesJson() async {
    return await latestMovieRemoteDataSource.getLatestMoviesJson();
  }

  @override
  List<LatestMovieModel> getLatestMovies(List<dynamic> movieJson) {
    return latestMovieRemoteDataSource.getLatestMovies(movieJson);
  }

  @override
  String getTrailerUrl(List<dynamic> trailerJson) {
    return latestMovieRemoteDataSource.getTrailerUrl(trailerJson);
  }

  @override
  Future<Movie> getSingleMovieDetail(int) {
    // TODO: implement getSingleMovieDetail
    throw UnimplementedError();
  }

}