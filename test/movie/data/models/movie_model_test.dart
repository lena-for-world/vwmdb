import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vwmdb/movie/data/models/latest_movie_model.dart';
import 'package:vwmdb/movie/domain/entities/movie_entity.dart';

import '../../../core/fixture/fixture_reader.dart';

void main() {
  final testLatestMovieModel = LatestMovieModel(movieId: 284052, title: 'doctor strange', poster: 'test.png', year: '2022');

  test('movie model은 movie entity의 하위 타입이어야 한다', () {
    final movieModel = LatestMovieModel(movieId: 284052, title: 'doctor strange', poster: '/test.png', year: '2022');
    expect(movieModel, isA<Movie>());
  });

  test('json data를 LatestMovieModel 오브젝트로 바꿀 수 있다', () {
    final Map<String, dynamic> jsonMap = json.decode(fixture('latest_movie.json'));

    final result = LatestMovieModel.fromJson(jsonMap);

    expect(result, testLatestMovieModel);
  });

}