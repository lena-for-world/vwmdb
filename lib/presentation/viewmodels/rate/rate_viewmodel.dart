import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../data/datasources/rate/rate_local_source.dart';
import '../../../data/models/rate/rate_model.dart';
import '../../../data/repositories/rate/rate_repository.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/rate/rate_usecase.dart';

final checkInWatchListStateProvider = StateProvider.autoDispose<int>((ref) => 0);

final rateProvider = Provider.autoDispose<RateUsecase>((ref) {
  RateLocalSource rateLocalSource = RateLocalSourceImpl(Hive.box('myMovies'));
  RateRepository rateRepository = RateRepositoryImpl(rateLocalSource);
  return RateUsecase(rateRepository);
});

final postMovieRatingProvider = Provider.autoDispose.family<void, RateSaver>((ref, toRating) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  rateUsecase.saveMovieIfNotInLocalStore(toRating.movie);
  rateUsecase.postMovieRating(toRating.movie.movieId, toRating.rating);
  ref.refresh(rateProvider);
});

final deleteMovieRatingProvider = Provider.autoDispose.family<void, int>((ref, movieId) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  rateUsecase.deleteMovieRated(movieId);
  ref.refresh(rateProvider);
});

final ratedStarsProvider = Provider.autoDispose.family<double?, int>((ref, movieId) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  return rateUsecase.getMovieRated(movieId);
});

final ifInWatchListProvider = Provider.autoDispose.family<bool, int>((ref, movieId) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  return rateUsecase.getIfMovieInWatchList(movieId);
});

final postMovieToWatchListProvider = Provider.autoDispose.family<void, Movie>((ref, movie) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  rateUsecase.saveMovieIfNotInLocalStore(movie);
  rateUsecase.postCheckOrUncheckMovieInWatchList(movie.movieId);
  ref.refresh(rateProvider);
});

final moviesInWatchlistProvider = Provider.autoDispose<List<int>>((ref) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  return rateUsecase.checkAllMoviesIfInWatchList();
});

final ratedListProvider = Provider.autoDispose<List<RateModel>>((ref) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  return rateUsecase.checkAllMoviesIfInRatedList();
});

class RateSaver {
  final Movie movie;
  final double rating;

  RateSaver(this.movie, this.rating);
}