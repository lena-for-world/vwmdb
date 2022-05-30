import 'package:hive/hive.dart';

import '../../domain/entities/rate_entity.dart';

@HiveType(typeId: 0)
class RateModel {

  // TODO : store options?
  // rate 는 내부저장소와 입출력하는 부분이라서
  // api를 이용하고 있지 않음
  // 내부 저장소로 객체를 저장할 때 (아마도) json 형식으로 직렬화
  // 가져와서 이용할 때 json형식을 객체로 바꾸는 역직렬화하게 될 듯
  // shared preferences는 json encode decode를 이용하여 저장하는 듯하고
  // hive는 ?
  // 그리고 이런 데이터를 저장하기에 적합한 다른 옵션은????

  @HiveField(0)
  int movieId;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? poster;
  @HiveField(3)
  int? stars;
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