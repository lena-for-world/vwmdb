import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/domain/usecases/movie/single_movie_usecase.dart';

import '../../../data/models/movie/single_movie_model.dart';

class SingleMovieViewModel extends ChangeNotifier {
  SingleMovieUsecase singleMovieUsecase;

  SingleMovieViewModel({required this.singleMovieUsecase});

  AsyncValue<SingleMovieModel> _singleMovie= AsyncValue.loading();

  AsyncValue<SingleMovieModel> get singleMovie => _singleMovie;

  void getSingleMovie(int movieId) async {
      _singleMovie = AsyncValue.data(await singleMovieUsecase.getSingleMovieDetail(movieId));
      notifyListeners();
  }
}