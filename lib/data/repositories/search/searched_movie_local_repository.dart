
import '../../datasources/search/searched_movie_local_source.dart';

abstract class SearchedMovieLocalRepository {
  List<String> getAllSearchedItems();
  void saveSearchedItem(String input);
}

class SearchedMovieLocalRepositoryImpl implements SearchedMovieLocalRepository {

  SearchedMovieLocalSource searchedMovieLocalSource;

  SearchedMovieLocalRepositoryImpl(this.searchedMovieLocalSource);

  @override
  List<String> getAllSearchedItems() {
    return searchedMovieLocalSource.getAllSearchedItems();
  }

  @override
  void saveSearchedItem(String input) {
    searchedMovieLocalSource.saveSearchedItem(input);
  }
}