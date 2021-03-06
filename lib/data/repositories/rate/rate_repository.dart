
import '../../../domain/entities/movie_entity.dart';
import '../../datasources/rate/rate_local_source.dart';
import '../../models/rate/rate_model.dart';

abstract class RateRepository {
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