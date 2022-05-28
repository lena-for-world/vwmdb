import '../datasources/single_movie_remote_data_source.dart';
import '../models/single_movie_model.dart';

abstract class SingleMovieRepository {
  Future<SingleMovieModel> getSingleMovieDetail(int movieId);
}

class SingleMovieRepositoryImpl implements SingleMovieRepository {

  SingleMovieRemoteDataSource singleMovieRemoteDataSource;

  SingleMovieRepositoryImpl(this.singleMovieRemoteDataSource);

  @override
  Future<SingleMovieModel> getSingleMovieDetail(int movieId) async {
    // TODO: implement getSingleMovieDetail
    return await singleMovieRemoteDataSource.getSingleMovieDetail(movieId);
  }

}