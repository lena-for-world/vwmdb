import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/network/api_key.dart';
import '../models/boxoffice_movie_model.dart';

// TODO : 인터페이스를 2개나 노출할필요가 잇나요.. 없음 외부 기준으로 정의하기
abstract class BoxofficeMovieRemoteDataSource {
  Future<List<BoxofficeMovieModel>> getBoxofficeMovies();
}

class BoxofficeMovieRemoteDataSourceImpl implements BoxofficeMovieRemoteDataSource {

  BoxofficeMovieRemoteDataSourceImpl();
  Dio dio = Dio(); // TODO: dio wrapping class (eX) themoviedbDio 네트워크 호출 repo만들기 / dio 1개만 만들어서 이용하는게 좋음

  @override
  Future<List<BoxofficeMovieModel>> getBoxofficeMovies() async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=${API_KEY}&language=en-US&page=1');
    List<dynamic> movieJson = json.decode(jsonMovies.toString())['results'];
    return makeBoxofficeMovieModels(movieJson);
  }

  // TODO: get보다는 convert or make가 더 어울리는 이름같다 (ex) makeBoxofficeMovieModels

  List<BoxofficeMovieModel> makeBoxofficeMovieModels(List<dynamic> movieJson) {
    List<BoxofficeMovieModel> boxofficeMovieModels = [];
    movieJson.forEach((movie) => {
      boxofficeMovieModels.add(
          BoxofficeMovieModel.fromJson(movie)
      )
    });
    return boxofficeMovieModels;
  }
}