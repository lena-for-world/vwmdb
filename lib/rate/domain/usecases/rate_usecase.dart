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

  void postMovieRating(int movieId, double rating) {
    rateRepository.postMovieRating(movieId, rating);
  }

  double? getMovieRated(int movieId) {
    if(!rateRepository.getIfMovieInLocalStore(movieId))
      return null;
    if(rateRepository.getIfMovieRated(movieId)) {
      return rateRepository.getMovieRated(movieId);
    } else {
      return null;
    }
  }

  bool getIfMovieInWatchList(int movieId) {
    // 영화가 리뷰가 있어서든, 별점을 매겼기 때문이든 저장되어 있긴 한 상태이므로
    // 시청목록에 추가가 되었는지도 확인이 필요
    bool inLocalStore = rateRepository.getIfMovieInLocalStore(movieId);
    if(inLocalStore == false)
      return false;
    return rateRepository.getIfInWatchList(movieId);
  }

  void saveMovieIfNotInLocalStore(int movieId) {
    bool inLocalStore = rateRepository.getIfMovieInLocalStore(movieId);
    if(!inLocalStore) {
      rateRepository.saveMovieIn(movieId);
    }
  }
}