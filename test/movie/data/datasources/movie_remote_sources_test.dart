import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vwmdb/movie/data/datasources/boxoffice_movie_remote_data_source.dart';
import 'package:vwmdb/movie/data/datasources/latest_movie_remote_sources.dart';
import 'package:vwmdb/movie/data/datasources/movie_remote_data_source.dart';
import 'package:vwmdb/movie/data/models/latest_movie_model.dart';
import 'package:vwmdb/movie/data/repositories/boxoffice_movie_repository.dart';
import 'package:vwmdb/movie/data/repositories/latest_movie_repository.dart';
import '../../../../lib/core/network/api_key.dart';

class MockRemoteDatasource extends Mock implements MovieRemoteDataSource {}

void main() {
  group('get latest movies list', ()
  {
    final dio = Dio();
    final latestMovieModel1 = LatestMovieModel(
        movieId: 752623, title: 'The Lost City', poster: '/A3bsT0m1um6tvcmlIGxBwx9eAxn.jpg', year: '2022-03-24');
    final testLatestMovieModels = [latestMovieModel1];

    LatestMovieRemoteDataSource? movieRemoteDataSource;
    LatestMovieRepository? latestMovieRepository;
    BoxofficeMovieRepository? boxofficeMovieRepository;
    BoxofficeMovieRemoteDataSource? boxofficeMovieRemotedataSource;

    setUp(() {
      movieRemoteDataSource = LatestMovieRemoteDataSourceImpl();
      latestMovieRepository = LatestMovieRepositoryImpl(movieRemoteDataSource!);
      boxofficeMovieRemotedataSource = BoxofficeMovieRemoteDataSourceImpl();
      boxofficeMovieRepository = BoxofficeMovieRepositoryImpl(boxofficeMovieRemotedataSource!);
    });

    test('latest movies list API를 가져올 수 있다', () async {
      final temp = await dio.get('https://api.themoviedb.org/3/movie/now_playing?api_key=${API_KEY}&page=1');
      final temp2 = json.decode(temp.toString());
      print(temp2);
      print(temp2.runtimeType);
      print(temp2['results'][0]['original_title']);
    });

    test('가져온 latest movies list API 결과를 모델로 변경해서 리턴할 수 있다', () async {
      final json = await latestMovieRepository!.getLatestMoviesJson();
      final result = latestMovieRepository!.getLatestMovies(json);

      result.forEach((element) {
        print('${element.poster} ${element.year} ${element.title}');
      });
    });

    test('트레일러 url을 가져올 수 있다', () async {
      final temp = await dio.get('https://api.themoviedb.org/3/movie/284052/videos?api_key=${API_KEY}&language=en-US');
      final temp2 = json.decode(temp.toString());
      print(temp2);
      print(temp2.runtimeType);
      print(temp2['results'][0]['id']);
    });

    test('트레일러 url을 조회할 수 있다', () async {
      final trailerJson = await latestMovieRepository!.getTrailerJson(284052);
      final result = latestMovieRepository!.getTrailerUrl(trailerJson);
      expect(result, '5c2d6d6dc3a368290ea437e6');
    });

    test('박스오피스 api를 가져올 수 있다', () async{
      final jsonResult = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=${API_KEY}&language=en-US&page=1');
      final result = json.decode(jsonResult.toString());
      print(result);
    });

    test('박스오피스 영화를 조회할 수 있다', () async {
      final jsonResult = await boxofficeMovieRepository!.getBoxofficeMoviesJson();
      final result = boxofficeMovieRepository!.getBoxofficeMovies(jsonResult);
      print(result);
    });
  });
}