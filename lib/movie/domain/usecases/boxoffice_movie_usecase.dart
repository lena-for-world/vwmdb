import 'package:vwmdb/movie/data/repositories/boxoffice_movie_repository.dart';

import '../../data/models/boxoffice_movie_model.dart';

class BoxofficeMovieUsecase {

  BoxofficeMovieRepository boxofficeMovieRepository;

  BoxofficeMovieUsecase(this.boxofficeMovieRepository);

  Future<List<BoxofficeMovieModel>> getBoxofficeMovies() async {
    /*List<dynamic> jsonMovies = await boxofficeMovieRepository.getBoxofficeMoviesJson();
    return boxofficeMovieRepository.getBoxofficeMovies(jsonMovies);*/
    return boxofficeMovieRepository.getBoxofficeMovies();
  }
}