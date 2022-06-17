import '../../../data/models/rate/rate_model.dart';
import '../../../data/repositories/rate/rate_repository.dart';
import '../../entities/movie_entity.dart';

class RateUsecase {
  RateRepository rateRepository;

  RateUsecase(this.rateRepository);

  void postMovieRating(Movie movie, double rating) {
    rateRepository.saveMovieIn(movie);
    rateRepository.postMovieRating(movie.movieId, rating);
  }

  void deleteMovieRated(int movieId) {
    rateRepository.deleteMovieRated(movieId);
  }

  double? getMovieRated(int movieId) {
    if(rateRepository.getIfMovieRated(movieId)) {
      return rateRepository.getMovieRated(movieId);
    } else {
      return null;
    }
  }

  List<RateModel> checkAllMoviesIfInRatedList() {
    List<RateModel> ratedList = [];
    rateRepository.getAllMovieKeys().forEach((movieId) {
      if(movieId.runtimeType == int && rateRepository.getIfInRatedList(movieId)) {
        ratedList.add(rateRepository.getSingleRateValue(movieId));
      }
    });
    return ratedList;
  }
}