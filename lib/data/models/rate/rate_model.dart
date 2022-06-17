import 'package:hive/hive.dart';
import 'package:vwmdb/core/network/poster.dart';

/// *
/// rate 평가를 위해서 movieId 필수.
/// 만약 movieId가 없다면, 영화를 처음 가져오는 시점에서 걸러내기 때문에
/// RateModel에서는 항상 movieId가 있다고 보고, null이 들어오는 경우를 처리하지 않았음.
///
@HiveType(typeId: 0)
class RateModel {

  @HiveField(0)
  int movieId;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? poster;
  @HiveField(3)
  double? stars;
  @HiveField(4)
  bool? watchOrNot;
  @HiveField(5)
  String? review;

  RateModel({
    required this.movieId,
    this.title,
    this.poster,
    this.stars,
    this.watchOrNot,
    this.review,
  });

  factory RateModel.fromJson(Map<String, dynamic> rateJson) {
    return RateModel(
      movieId: rateJson['movieId'],
      title: rateJson['title'] ?? null,
      poster: rateJson['poster'] ?? defaultPoster,
      stars: rateJson['stars'] ?? null,
      watchOrNot: rateJson['watchOrNot'] ?? null,
      review: rateJson['review'] ?? null,
    );
  }

  Map<String, dynamic> toJson() => {
    'movieId': movieId,
    'title' : title ?? null,
    'poster': poster ?? null,
    'stars' : stars ?? null,
    'watchOrNot': watchOrNot ?? null,
    'review' : review ?? null,
  };
}