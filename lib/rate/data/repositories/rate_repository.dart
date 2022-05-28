import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';

abstract class RateRepository {
  bool getIfMovieInWatchList(int movieId);
}

class RateRepositoryImpl implements RateRepository {
  RateLocalSource rateLocalSource;

  RateRepositoryImpl(this.rateLocalSource);

  @override
  bool getIfMovieInWatchList(int movieId) {
    // TODO: implement getIfMovieInWatchList
    return rateLocalSource.getIfMovieInWatchList(movieId);
  }
}