import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../data/datasources/rate/rate_local_source.dart';
import '../../../data/repositories/rate/rate_repository.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/rate/watchlist_usecase.dart';

final watchlistProvider = Provider.autoDispose<WatchlistUseCase>((ref) {
  RateLocalSource rateLocalSource = RateLocalSourceImpl(Hive.box('myMovies'));
  RateRepository rateRepository = RateRepositoryImpl(rateLocalSource);
  return WatchlistUseCase(rateRepository);
});

final ifInWatchListProvider = Provider.autoDispose.family<bool, int>((ref, movieId) {
  WatchlistUseCase watchlistUseCase = ref.watch(watchlistProvider);
  return watchlistUseCase.getIfMovieInWatchList(movieId);
});

final postMovieToWatchListProvider = Provider.autoDispose.family<void, Movie>((ref, movie) {
  WatchlistUseCase watchlistUseCase = ref.watch(watchlistProvider);
  watchlistUseCase.postCheckOrUncheckMovieInWatchList(movie);
  ref.refresh(watchlistProvider);
});

final moviesInWatchlistProvider = Provider.autoDispose<List<int>>((ref) {
  WatchlistUseCase watchlistUseCase = ref.watch(watchlistProvider);
  return watchlistUseCase.checkAllMoviesIfInWatchList();
});