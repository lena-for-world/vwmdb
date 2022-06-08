import '../datasources/searched_movie_remote_data_source.dart';
import '../models/searched_movie_model.dart';

abstract class SearchedMovieRepository {
  Future<List<dynamic>> getSearchedResult(String input);
  List<SearchedMovieModel> getSearchedMovies(List<dynamic> movieJson);
}

class SearchedMovieRepositoryImpl implements SearchedMovieRepository {
  SearchedRemoteDatasource searchedRemoteDatasource;

  SearchedMovieRepositoryImpl(this.searchedRemoteDatasource);

  @override
  Future<List<dynamic>> getSearchedResult(String input) async {
    return await searchedRemoteDatasource.getSearchedResult(input);
  }

  @override
  List<SearchedMovieModel> getSearchedMovies(List<dynamic> movieJson) {
    return searchedRemoteDatasource.getSearchedMovies(movieJson);
  }


}