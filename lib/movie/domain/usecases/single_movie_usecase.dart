import 'package:vwmdb/movie/data/repositories/movie_repository.dart';

import '../../data/models/single_movie_model.dart';
import '../../data/repositories/single_movie_repository.dart';

class SingleMovieUsecase {

  SingleMovieRepository singleMovieRepository;

  SingleMovieUsecase(this.singleMovieRepository);

  Future<SingleMovieModel> getSingleMovieDetail(int movieId) async {
    return await singleMovieRepository.getSingleMovieDetail(movieId);
  }
}