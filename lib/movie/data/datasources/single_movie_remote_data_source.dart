import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vwmdb/movie/data/models/single_movie_model.dart';

import '../../../core/network/api_key.dart';

abstract class SingleMovieRemoteDataSource {
  Future<SingleMovieModel> getSingleMovieDetail(int movieId);
}

class SingleMovieRemoteDataSourceImpl implements SingleMovieRemoteDataSource {

  Dio dio = Dio();

  @override
  Future<SingleMovieModel> getSingleMovieDetail(int movieId) async {
    // TODO: implement getSingleMovieDetail
    final movieResult = await dio.get('https://api.themoviedb.org/3/movie/${movieId}?api_key=${API_KEY}&language=en-US');
    final jsonMovie = json.decode(movieResult.toString());
    return SingleMovieModel.fromJson(jsonMovie);
  }



}