

import '../../../data/models/rate/rate_model.dart';
import '../../../data/repositories/rate/rate_repository.dart';
import '../../entities/movie_entity.dart';

//TODO: 유스케이스 기준 잡아서 변경하기
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

  bool getIfMovieInRatedList(int movieId) {
    // 영화가 리뷰가 있어서든, 별점을 매겼기 때문이든 저장되어 있긴 한 상태이므로
    // 시청목록에 추가가 되었는지도 확인이 필요
    bool inLocalStore = rateRepository.getIfMovieInLocalStore(movieId);
    if(inLocalStore == false)
      return false;
    return rateRepository.getIfInRatedList(movieId);
  }

  void saveMovieIfNotInLocalStore(Movie movie) {
    bool inLocalStore = rateRepository.getIfMovieInLocalStore(movie.movieId);
    if(!inLocalStore) {
      rateRepository.saveMovieIn(movie);
    }
  }

  List<int> checkAllMoviesIfInWatchList() {
    List<int> isInWatchList = [];
    rateRepository.getAllMovieKeys().forEach((element) {
      if(element.runtimeType == int && getIfMovieInWatchList(element)) {
        isInWatchList.add(element);
      }
    });
    return isInWatchList;
  }

  List<RateModel> checkAllMoviesIfInRatedList() {
    List<RateModel> ratedList = [];
    rateRepository.getAllMovieKeys().forEach((movieId) {
      print('rated: ${movieId}');
      if(movieId.runtimeType == int && getIfMovieInRatedList(movieId)) {
        ratedList.add(rateRepository.getSingleRateValue(movieId));
      }
    });
    return ratedList;
  }
}