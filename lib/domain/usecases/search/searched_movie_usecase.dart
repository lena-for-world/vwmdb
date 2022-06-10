import '../../../data/models/search/searched_movie_model.dart';
import '../../../data/repositories/search/searched_movie_repository.dart';

class SearchedMovieUsecase {
  SearchedMovieRepository searchedMovieRepository;

  SearchedMovieUsecase(this.searchedMovieRepository);

  Future<List<SearchedMovieModel>> getSearchedMovies(String input) async {
    return searchedMovieRepository.getSearchedResult(input);
  }
}