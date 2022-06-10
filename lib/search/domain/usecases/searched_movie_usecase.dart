import 'package:vwmdb/search/data/models/searched_movie_model.dart';
import 'package:vwmdb/search/data/repositories/searched_movie_repository.dart';

class SearchedMovieUsecase {
  SearchedMovieRepository searchedMovieRepository;

  SearchedMovieUsecase(this.searchedMovieRepository);

  Future<List<SearchedMovieModel>> getSearchedMovies(String input) async {
    final moviesJson = await searchedMovieRepository.getSearchedResult(input);
    return searchedMovieRepository.getSearchedMovies(moviesJson);
  }
}