import 'package:vwmdb/movie/data/datasources/latest_movie_remote_sources.dart';

import '../../domain/entities/movie_entity.dart';
import '../datasources/movie_remote_data_source.dart';
import '../models/latest_movie_model.dart';
import 'movie_repository.dart';

abstract class LatestMovieRepository {
 // Future<List<dynamic>> getTrailerJson(int movieId);
  /*Future<List<dynamic>> getLatestMoviesJson();
  List<LatestMovieModel> getLatestMovies(List<dynamic> movieJson);
*/  Future<List<LatestMovieModel>> getLatestMovies();
 // String getTrailerUrl(List<dynamic> trailerJson);
  Future<String> getTrailerUrl(int movieId);
}

class LatestMovieRepositoryImpl implements LatestMovieRepository {
  final LatestMovieRemoteDataSource latestMovieRemoteDataSource;

  LatestMovieRepositoryImpl(this.latestMovieRemoteDataSource);
  //
  // @override
  // Future<List<dynamic>> getTrailerJson(int movieId) async {
  //   return await latestMovieRemoteDataSource.getTrailerJson(movieId);
  // }
/*
  @override
  Future<List<dynamic>> getLatestMoviesJson() async {
    return await latestMovieRemoteDataSource.getLatestMoviesJson();
  }

  @override
  List<LatestMovieModel> getLatestMovies(List<dynamic> movieJson) {
    return latestMovieRemoteDataSource.getLatestMovies(movieJson);
  }*/


  @override
  Future<String> getTrailerUrl(int movieId) {
    return latestMovieRemoteDataSource.getTrailerUrl(movieId);
  }

  @override
  Future<List<LatestMovieModel>> getLatestMovies() {
    return latestMovieRemoteDataSource.getLatestMovies();
  }

}