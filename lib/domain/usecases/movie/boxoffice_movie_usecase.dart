import '../../../data/models/movie/boxoffice_movie_model.dart';
import '../../../data/repositories/movie/movie_repository.dart';

class BoxofficeMovieUsecase {

  MovieRepository movieRepository;

  BoxofficeMovieUsecase(this.movieRepository);

  Future<List<BoxofficeMovieModel>> getBoxofficeMovies() async {
    return movieRepository.getBoxofficeMovies();
  }
}