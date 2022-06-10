import 'package:vwmdb/search/data/datasources/searched_movie_local_source.dart';

abstract class SearchedMovieLocalRepository {
  void saveSearchedKeyInLocalStoreIfNotExists();
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

  @override
  void saveSearchedKeyInLocalStoreIfNotExists() {
    searchedMovieLocalSource.saveSearchedKeyInLocalStoreIfNotExists();
  }

}