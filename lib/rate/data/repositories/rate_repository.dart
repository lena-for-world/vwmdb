import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';

import '../../../movie/data/models/single_movie_model.dart';
import '../../../movie/domain/entities/movie_entity.dart';
import '../models/rate_model.dart';

abstract class RateRepository {
  bool getIfMovieInLocalStore(int movieId);
  void postCheckOrUncheckMovieInWatchList(int movieId);
  bool getIfMovieRated(int moviedId);
  bool getIfInWatchList(int movieId);
  double getMovieRated(int movieId);
  void postMovieRating(int movieId, double rating);
  void deleteMovieRated(int movieId);
  void saveMovieIn(Movie movie);
  Iterable<dynamic> getAllMovieKeys();
  bool getIfInRatedList(int movieId);
  RateModel getSingleRateValue(int movieId);
}

class RateRepositoryImpl implements RateRepository {
  RateLocalSource rateLocalSource;

  RateRepositoryImpl(this.rateLocalSource);

  @override
  bool getIfMovieInLocalStore(int movieId) {
    return rateLocalSource.getIfMovieInLocalStore(movieId);
  }

  @override
  void deleteMovieRated(int movieId) {
    rateLocalSource.deleteMovieRated(movieId);
  }

  @override
  bool getIfMovieRated(int movieId) {
    return rateLocalSource.getIfMovieRated(movieId);
  }

  @override
  bool getIfInRatedList(int movieId) {
    return rateLocalSource.getIfInRatedList(movieId);
  }

  @override
  double getMovieRated(int movieId) {
    return rateLocalSource.getMovieRated(movieId);
  }

  @override
  void postCheckOrUncheckMovieInWatchList(int movieId) {
    rateLocalSource.postCheckOrUncheckMovieInWatchList(movieId);
  }

  @override
  void postMovieRating(int movieId, double rating) {
    rateLocalSource.postMovieRating(movieId, rating);
  }

  @override
  bool getIfInWatchList(int movieId) {
    return rateLocalSource.getIfInWatchList(movieId);
  }

  @override
  void saveMovieIn(Movie movie) {
    rateLocalSource.saveMovieIn(movie);
  }

  @override
  Iterable getAllMovieKeys() {
    return rateLocalSource.getAllMovieKeys();
  }

  @override
  RateModel getSingleRateValue(int movieId) {
    return rateLocalSource.getSingleRateValue(movieId);
  }
}