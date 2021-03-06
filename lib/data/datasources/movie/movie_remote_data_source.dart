import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vwmdb/core/network/dio.dart';

import '../../../../core/network/api.dart';
import '../../models/movie/boxoffice_movie_model.dart';
import '../../models/movie/latest_movie_model.dart';
import '../../models/movie/single_movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<BoxofficeMovieModel>> getBoxofficeMovies();
  Future<List<LatestMovieModel>> getLatestMovies();
  Future<String> getTrailerUrl(int movieId);
  Future<SingleMovieModel> getSingleMovieDetail(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {

  MovieRemoteDataSourceImpl();
  Dio dio = Dio();//DioImpl().getInstance;

  @override
  Future<List<LatestMovieModel>> getLatestMovies() async {
    final jsonMovies = await dio.get('${API_SOURCE}/movie/now_playing?api_key=${API_KEY}');
    List<dynamic> movieJson = json.decode(jsonMovies.toString())['results'];
    return makeLatestMovieModels(movieJson);
  }

  List<LatestMovieModel> makeLatestMovieModels(List<dynamic> movieJson) {
    List<LatestMovieModel> latestMovieModels = movieJson
        .map((movie) => LatestMovieModel.fromJson(movie))
        .toList()
        .where((converted) => converted.movieId != 0)
        .toList();
    return latestMovieModels;
  }

  @override
  Future<String> getTrailerUrl(int movieId) async {
    final jsonMovies = await dio.get('${API_SOURCE}/movie/${movieId}/videos?api_key=${API_KEY}&language=en-US');
    List<dynamic> trailerJson = json.decode(jsonMovies.toString())['results'];
    return giveTrailerUrl(trailerJson);
  }

  String giveTrailerUrl(List<dynamic> trailerJson) {
    return trailerJson[0]['key'];
  }

  @override
  Future<List<BoxofficeMovieModel>> getBoxofficeMovies() async {
    final jsonMovies = await dio.get('${API_SOURCE}/movie/popular?api_key=${API_KEY}&language=en-US&page=1');
    List<dynamic> movieJson = json.decode(jsonMovies.toString())['results'];
    return makeBoxofficeMovieModels(movieJson);
  }

  List<BoxofficeMovieModel> makeBoxofficeMovieModels(List<dynamic> movieJson) {
    List<BoxofficeMovieModel> boxofficeMovieModels = movieJson
        .map((movie) => BoxofficeMovieModel.fromJson(movie))
        .toList()
        .where((converted) => converted.movieId != 0)
        .toList();
    return boxofficeMovieModels;
  }

  @override
  Future<SingleMovieModel> getSingleMovieDetail(int movieId) async {
    final movieResult = await dio.get('${API_SOURCE}/movie/${movieId}?api_key=${API_KEY}&language=en-US');
    final jsonMovie = json.decode(movieResult.toString());
    return SingleMovieModel.fromJson(jsonMovie);
  }

}