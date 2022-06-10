import 'package:equatable/equatable.dart';

class Rate extends Equatable {
  int movieId;
  String title;
  String? poster;
  int? stars;
  bool? watchOrNot;
  String? review;

  Rate({
    required this.movieId,
    required this.title,
    this.poster,
    this.stars,
    this.watchOrNot,
    this.review,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [this.movieId,
    this.title,
    this.poster,
    this.stars,
    this.watchOrNot,
    this.review
  ];
}