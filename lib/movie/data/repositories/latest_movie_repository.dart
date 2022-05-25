import 'package:vwmdb/movie/data/datasources/latest_movie_remote_sources.dart';

import '../../domain/entities/movie_entity.dart';
import '../datasources/movie_remote_data_source.dart';
import '../models/latest_movie_model.dart';
import 'movie_repository.dart';

abstract class LatestMovieRepository {
  Future<List<LatestMovieModel>> getLatestMovies();
  Future<String> getTrailerUrl(int movieId);
}

class LatestMovieRepositoryImpl implements MovieRepository, LatestMovieRepository {
  final LatestMovieRemoteDataSource latestMovieRemoteDataSource;

  LatestMovieRepositoryImpl(this.latestMovieRemoteDataSource);

  @override
  Future<List<LatestMovieModel>> getLatestMovies() async {
    return await latestMovieRemoteDataSource.getLatestMovies();
  }

  @override
  Future<Movie> getSingleMovieDetail(int) {
    // TODO: implement getSingleMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<String> getTrailerUrl(int movieId) async {
    // TODO: implement getTrailerUrl
    return await latestMovieRemoteDataSource.getTrailerUrl(movieId);
  }

}