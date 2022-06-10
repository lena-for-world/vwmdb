import '../../datasources/search/searched_movie_remote_data_source.dart';
import '../../models/search/searched_movie_model.dart';

abstract class SearchedMovieRepository {
  // Future<List<dynamic>> getSearchedResult(String input);
  // List<SearchedMovieModel> getSearchedMovies(List<dynamic> movieJson);
  Future<List<SearchedMovieModel>> getSearchedResult(String input);
}

class SearchedMovieRepositoryImpl implements SearchedMovieRepository {
  SearchedRemoteDatasource searchedRemoteDatasource;

  SearchedMovieRepositoryImpl(this.searchedRemoteDatasource);

  @override
  Future<List<SearchedMovieModel>> getSearchedResult(String input) {
    return searchedRemoteDatasource.getSearchedResult(input);
  }

  // @override
  // Future<List<dynamic>> getSearchedResult(String input) async {
  //   return await searchedRemoteDatasource.getSearchedResult(input);
  // }
  //
  // @override
  // List<SearchedMovieModel> getSearchedMovies(List<dynamic> movieJson) {
  //   return searchedRemoteDatasource.getSearchedMovies(movieJson);
  // }



}