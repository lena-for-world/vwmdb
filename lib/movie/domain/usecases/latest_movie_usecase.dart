import 'package:vwmdb/movie/data/repositories/latest_movie_repository.dart';

import '../../data/models/latest_movie_model.dart';

class LatestMovieUsecase {
  LatestMovieRepository latestMovieRepository;

  LatestMovieUsecase(this.latestMovieRepository);

  Future<List<LatestMovieModel>> getLatestMovies() async {
    List<dynamic> movieJson = await latestMovieRepository.getLatestMoviesJson();
    return latestMovieRepository.getLatestMovies(movieJson);
  }

  Future<String> getTrailer(int movieId) async {
    List<dynamic> urlJson= await latestMovieRepository.getTrailerJson(movieId);
    return latestMovieRepository.getTrailerUrl(urlJson);
  }
}