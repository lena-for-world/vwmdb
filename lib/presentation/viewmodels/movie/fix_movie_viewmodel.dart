import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/domain/usecases/movie/boxoffice_movie_usecase.dart';
import 'package:vwmdb/domain/usecases/movie/latest_movie_usecase.dart';
import 'package:vwmdb/domain/usecases/movie/single_movie_usecase.dart';

import '../../../data/models/movie/boxoffice_movie_model.dart';
import '../../../data/models/movie/latest_movie_model.dart';
import '../../../data/models/movie/single_movie_model.dart';

// usecase 쓰임이 어디에 쓰이느지 눈에 잘보임
class MovieViewModel extends ChangeNotifier {
  LatestMovieUsecase latestMovieUsecase;
  BoxofficeMovieUsecase boxofficeMovieUsecase;
  //SingleMovieUsecase singleMovieUsecase;

  AsyncValue<List<LatestMovieModel>> _latestMoviesList = AsyncValue.loading();
  AsyncValue<List<BoxofficeMovieModel>> _boxofficeMoviesList = AsyncValue.loading();
  //AsyncValue<SingleMovieModel> _singleMovie= AsyncValue.loading();
  AsyncValue<String> _trailerId = AsyncValue.loading();

  AsyncValue<List<LatestMovieModel>> get latestMoviesList => _latestMoviesList;
  AsyncValue<List<BoxofficeMovieModel>> get boxofficeMoviesList => _boxofficeMoviesList;
 // AsyncValue<SingleMovieModel> get singleMovie => _singleMovie;
  AsyncValue<String> get trailerId => _trailerId;

  MovieViewModel({
    required this.latestMovieUsecase,
    required this.boxofficeMovieUsecase,
   // required this.singleMovieUsecase
  }) {
    getMovies();
  }

  void getMovies() async {
    _latestMoviesList = AsyncValue.data(await latestMovieUsecase.getLatestMovies());
    _boxofficeMoviesList = AsyncValue.data(await boxofficeMovieUsecase.getBoxofficeMovies());
    notifyListeners();
  }

  // void getSingleMovie(int movieId) async {
  //   _singleMovie = AsyncValue.data(await singleMovieUsecase.getSingleMovieDetail(movieId));
  // //  notifyListeners();
  // }
  //
  void getTrailerId(int movieId) async {
    _trailerId = AsyncValue.data(await latestMovieUsecase.getTrailer(movieId));
    notifyListeners();
  }

}