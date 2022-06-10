import 'package:vwmdb/movie/data/repositories/latest_movie_repository.dart';

import '../../data/models/latest_movie_model.dart';

class LatestMovieUsecase {
  LatestMovieRepository latestMovieRepository;

  LatestMovieUsecase(this.latestMovieRepository);

  Future<List<LatestMovieModel>> getLatestMovies() async {
    return latestMovieRepository.getLatestMovies();
  }

  Future<String> getTrailer(int movieId) async {
    return latestMovieRepository.getTrailerUrl(movieId);
  }
}