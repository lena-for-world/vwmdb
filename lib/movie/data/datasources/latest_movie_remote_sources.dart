
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/network/api_key.dart';
import '../../domain/entities/movie_entity.dart';
import '../models/latest_movie_model.dart';

abstract class LatestMovieRemoteDataSource {
  Future<List<dynamic>> getTrailerJson(int movieId);
  Future<List<dynamic>> getLatestMoviesJson();
  List<LatestMovieModel> getLatestMovies(List<dynamic> movieJson);
  String getTrailerUrl(List<dynamic> trailerJson);
}

class LatestMovieRemoteDataSourceImpl implements LatestMovieRemoteDataSource {

  LatestMovieRemoteDataSourceImpl();
  Dio dio = Dio();

  @override
  Future<List<dynamic>> getLatestMoviesJson() async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/now_playing?api_key=${API_KEY}');
    return json.decode(jsonMovies.toString())['results'];
  }

  @override
  List<LatestMovieModel> getLatestMovies(List<dynamic> movieJson) {
    // TODO: implement getLatestMovies
    List<LatestMovieModel> latestMovieModels = [];
    movieJson.forEach((movie) => {
      latestMovieModels.add(
          LatestMovieModel.fromJson(movie)
      )
    });
    return latestMovieModels;
  }

  @override
  Future<Movie> getSingleMovieDetail(int) {
    // TODO: implement getSingleMovieDetail
    throw UnimplementedError();
  }

  Future<List<dynamic>> getTrailerJson(int movieId) async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/${movieId}/videos?api_key=${API_KEY}&language=en-US');
    return json.decode(jsonMovies.toString())['results'];
  }

  @override
  String getTrailerUrl(List<dynamic> trailerJson) {
    // TODO: implement getTrailerUrl
    return trailerJson[0]['id'];
  }
  
}