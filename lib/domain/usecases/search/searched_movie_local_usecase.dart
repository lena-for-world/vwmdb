import '../../../data/repositories/search/searched_movie_local_repository.dart';

class SearchedMovieLocalUsecase {
  SearchedMovieLocalRepository searchedMovieLocalRepository;

  SearchedMovieLocalUsecase(this.searchedMovieLocalRepository);

  List<String> getSearchedMoviesInLocal() {
    searchedMovieLocalRepository.saveSearchedKeyInLocalStoreIfNotExists();
    return searchedMovieLocalRepository.getAllSearchedItems();
  }

  void saveSearchedMovieInLocal(String input) {
    searchedMovieLocalRepository.saveSearchedKeyInLocalStoreIfNotExists();
    searchedMovieLocalRepository.saveSearchedItem(input);
  }
}