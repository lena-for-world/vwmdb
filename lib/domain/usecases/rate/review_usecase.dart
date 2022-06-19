import 'package:vwmdb/data/repositories/rate/review_repository.dart';

class ReviewUsecase {

  ReviewRepository reviewRepository;

  ReviewUsecase(this.reviewRepository);

  void saveReview(int movieId, String review) {
    reviewRepository.saveReview(movieId, review);
  }

  String getReview(int movieId) {
    return reviewRepository.getReview(movieId);
  }
}