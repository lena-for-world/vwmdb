import '../../../data/models/movie/latest_movie_model.dart';
import '../../../data/repositories/movie/movie_repository.dart';

class LatestMovieUsecase {

  MovieRepository movieRepository;

  LatestMovieUsecase(this.movieRepository);

  Future<List<LatestMovieModel>> getLatestMovies() async {
    return movieRepository.getLatestMovies();
  }

  Future<String> getTrailer(int movieId) async {
    return movieRepository.getTrailerUrl(movieId);
  }
}