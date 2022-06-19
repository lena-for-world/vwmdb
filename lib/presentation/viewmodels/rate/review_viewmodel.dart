import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/data/datasources/rate/review_remote_source.dart';
import 'package:vwmdb/data/repositories/rate/review_repository.dart';

final reviewSaver = Provider.autoDispose.family<void, Review>((ref, review) {
  ReviewRemoteSource remoteSource = ReviewRemoteSourceImpl();
  ReviewRepository reviewRepository = ReviewRepositoryImpl(remoteSource);
  reviewRepository.saveReview(review.movieId, review.text);
});

final reviewGetter = Provider.autoDispose.family<String, int>((ref, movieId) {
  ReviewRemoteSource remoteSource = ReviewRemoteSourceImpl();
  ReviewRepository reviewRepository = ReviewRepositoryImpl(remoteSource);
  return reviewRepository.getReview(movieId);
});

class Review {
  int movieId;
  String text;
  Review(this.movieId, this.text);
}