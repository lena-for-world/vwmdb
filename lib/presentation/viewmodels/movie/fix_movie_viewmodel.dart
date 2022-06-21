import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/domain/usecases/movie/boxoffice_movie_usecase.dart';
import 'package:vwmdb/domain/usecases/movie/latest_movie_usecase.dart';
import 'package:vwmdb/domain/usecases/movie/single_movie_usecase.dart';

import '../../../data/models/movie/latest_movie_model.dart';

// usecase 쓰임이 어디에 쓰이느지 눈에 잘보임
class MovieViewModel {
  LatestMovieUsecase latestMovieUsecase;
  BoxofficeMovieUsecase boxofficeMovieUsecase;
  SingleMovieUsecase singleMovieUsecase;

  AsyncValue<List<LatestMovieModel>> _latestMoviesList = AsyncValue.loading();

  AsyncValue<List<LatestMovieModel>> get latestMoviesList => _latestMoviesList;

  MovieViewModel({
    required this.latestMovieUsecase,
    required this.boxofficeMovieUsecase,
    required this.singleMovieUsecase
  }) {
    getMovies();
  }

  void getMovies() async {
    _latestMoviesList = AsyncValue.data(await latestMovieUsecase.getLatestMovies());
  }

}