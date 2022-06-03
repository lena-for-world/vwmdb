import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';

abstract class RateRepository {
  bool getIfMovieInLocalStore(int movieId);
  void postCheckOrUncheckMovieInWatchList(int movieId);
  bool getIfMovieRated(int moviedId);
  bool getIfInWatchList(int movieId);
  double getMovieRated(int movieId);
  void postMovieRating(int movieId, double rating);
  void deleteMovieRated(int movieId);
  void saveMovieIn(int movieId);
  Iterable<dynamic> getAllMovieKeys();
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
  void saveMovieIn(int movieId) {
    rateLocalSource.saveMovieIn(movieId);
  }

  @override
  Iterable getAllMovieKeys() {
    return rateLocalSource.getAllMovieKeys();
  }
}