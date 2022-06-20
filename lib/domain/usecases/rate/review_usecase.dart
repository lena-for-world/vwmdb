import 'package:vwmdb/data/repositories/rate/review_repository.dart';

import '../../../data/models/rate/review_model.dart';

class ReviewUsecase {

  ReviewRepository reviewRepository;

  ReviewUsecase(this.reviewRepository);

  void saveReview(int movieId, String review) {
    reviewRepository.saveReview(movieId, review);
  }

  Future<String?> getReview(int movieId) async {
    return reviewRepository.getReview(movieId);
  }

  Future<List<ReviewModel>> getReviewAll() async {
    return reviewRepository.getReviewAll();
  }
}