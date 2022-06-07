import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class RateModel {

  // TODO : store options?, required

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
      poster: rateJson['poster'] ?? null,
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