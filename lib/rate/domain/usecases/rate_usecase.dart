import 'package:vwmdb/rate/data/repositories/rate_repository.dart';

class RateUsecase {
  RateRepository rateRepository;

  RateUsecase(this.rateRepository);

  void postCheckOrUncheckMovieInWatchList(int movieId) {
    rateRepository.postCheckOrUncheckMovieInWatchList(movieId);
  }

  void deleteMovieRated(int movieId) {
    rateRepository.deleteMovieRated(movieId);
  }

  void postMovieRating(int movieId, int rating) {
    rateRepository.postMovieRating(movieId, rating);
  }

  int? getMovieRated(int movieId) {
    if(rateRepository.getIfMovieRated(movieId)) {
      return rateRepository.getMovieRated(movieId);
    } else {
      return null;
    }
  }

  bool getIfMovieInWatchList(int movieId) {
    return rateRepository.getIfMovieInWatchList(movieId);
  }

}