class ReviewModel {
  int movieId;
  String content;

  ReviewModel({required this.movieId, required this.content});

  factory ReviewModel.fromJson(int key, String value) {
    return ReviewModel(
      movieId: key,
      content: value,
    );
  }
}