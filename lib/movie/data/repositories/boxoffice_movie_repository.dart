import 'package:vwmdb/movie/data/models/boxoffice_movie_model.dart';

import '../datasources/boxoffice_movie_remote_data_source.dart';

abstract class BoxofficeMovieRepository {
  /*Future<List<dynamic>> getBoxofficeMoviesJson();
  List<BoxofficeMovieModel> getBoxofficeMovies(List<dynamic> jsonMovies);
  */Future<List<BoxofficeMovieModel>> getBoxofficeMovies();
}

class BoxofficeMovieRepositoryImpl implements BoxofficeMovieRepository {

  final BoxofficeMovieRemoteDataSource boxofficeMovieRemoteDataSource;

  BoxofficeMovieRepositoryImpl(this.boxofficeMovieRemoteDataSource);

  /*@override
  Future<List<dynamic>> getBoxofficeMoviesJson() async {
    return await boxofficeMovieRemoteDataSource.getBoxofficeMoviesJson();
  }

  @override
  List<BoxofficeMovieModel> getBoxofficeMovies(List<dynamic> jsonMovies) {
    return boxofficeMovieRemoteDataSource.getBoxofficeMovies(jsonMovies);
  }
*/
  @override
  Future<List<BoxofficeMovieModel>> getBoxofficeMovies() async {
    return boxofficeMovieRemoteDataSource.getBoxofficeMovies();
  }

}