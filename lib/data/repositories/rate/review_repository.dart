import 'package:vwmdb/data/datasources/rate/review_remote_source.dart';

abstract class ReviewRepository {
  void saveReview(int movieId, String review);
  String getReview(int movieId);
}

class ReviewRepositoryImpl implements ReviewRepository {

  ReviewRemoteSource remoteSource;

  ReviewRepositoryImpl(this.remoteSource);

  @override
  void saveReview(int movieId, String review) {
    remoteSource.saveReview(movieId, review);
  }

  @override
  String getReview(int movieId) {
    return remoteSource.getReview(movieId);
  }

}