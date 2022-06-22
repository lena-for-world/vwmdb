import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../data/datasources/rate/rate_local_source.dart';
import '../../../data/models/rate/rate_model.dart';
import '../../../data/repositories/rate/rate_repository.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/rate/rate_usecase.dart';

final checkInWatchListStateProvider = StateProvider<int>((ref) => 0);

final rateProvider = Provider.autoDispose<RateUsecase>((ref) {
  RateLocalSource rateLocalSource = RateLocalSourceImpl(Hive.box('myMovies'));
  RateRepository rateRepository = RateRepositoryImpl(rateLocalSource);
  return RateUsecase(rateRepository);
});

final postMovieRatingProvider = Provider.autoDispose.family<void, RateSaver>((ref, toRating) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  rateUsecase.postMovieRating(toRating.movie, toRating.rating);
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

final ratedListProvider = Provider.autoDispose<List<RateModel>>((ref) {
  RateUsecase rateUsecase = ref.watch(rateProvider);
  return rateUsecase.checkAllMoviesIfInRatedList();
});

class RateSaver {
  final Movie movie;
  final double rating;

  RateSaver(this.movie, this.rating);
}