import 'package:vwmdb/data/datasources/rate/review_remote_source.dart';

import '../../models/rate/review_model.dart';

abstract class ReviewRepository {
  void saveReview(int movieId, String review);
  Future<String?> getReview(int movieId);
  Future<List<ReviewModel>> getReviewAll();
}

class ReviewRepositoryImpl implements ReviewRepository {

  ReviewRemoteSource remoteSource;

  ReviewRepositoryImpl(this.remoteSource);

  @override
  void saveReview(int movieId, String review) {
    remoteSource.saveReview(movieId, review);
  }

  @override
  Future<String?> getReview(int movieId) {
    return remoteSource.getReview(movieId);
  }

  @override
  Future<List<ReviewModel>> getReviewAll() {
    return remoteSource.getReviewAll();
  }

  // @override
  // String fromDatabase(String data) {
  //   return remoteSource.fromDatabase(data);
  // }

}