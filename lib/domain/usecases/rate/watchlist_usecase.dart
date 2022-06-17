import '../../../data/repositories/rate/rate_repository.dart';
import '../../entities/movie_entity.dart';

class WatchlistUseCase {

  RateRepository rateRepository;

  WatchlistUseCase(this.rateRepository);

  void postCheckOrUncheckMovieInWatchList(Movie movie) {
    rateRepository.saveMovieIn(movie);
    rateRepository.postCheckOrUncheckMovieInWatchList(movie.movieId);
  }

  bool getIfMovieInWatchList(int movieId) {
    // 영화가 리뷰가 있어서든, 별점을 매겼기 때문이든 저장되어 있긴 한 상태이므로
    // 시청목록에 추가가 되었는지도 확인이 필요
    return rateRepository.getIfInWatchList(movieId);
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
}