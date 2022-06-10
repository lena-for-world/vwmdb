
import '../../../data/models/movie/single_movie_model.dart';
import '../../../data/repositories/movie/movie_repository.dart';
class SingleMovieUsecase {

  MovieRepository movieRepository;

  SingleMovieUsecase(this.movieRepository);

  Future<SingleMovieModel> getSingleMovieDetail(int movieId) async {
    return await movieRepository.getSingleMovieDetail(movieId);
  }
}