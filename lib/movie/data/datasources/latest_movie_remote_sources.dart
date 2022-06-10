
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/network/api_key.dart';
import '../../domain/entities/movie_entity.dart';
import '../models/latest_movie_model.dart';

abstract class LatestMovieRemoteDataSource {
  //Future<List<dynamic>> getTrailerJson(int movieId);
/*  Future<List<dynamic>> getLatestMoviesJson();
  List<LatestMovieModel> getLatestMovies(List<dynamic> movieJson);*/
  //String getTrailerUrl(List<dynamic> trailerJson);
  Future<List<LatestMovieModel>> getLatestMovies();
  Future<String> getTrailerUrl(int movieId);
}

class LatestMovieRemoteDataSourceImpl implements LatestMovieRemoteDataSource {

  LatestMovieRemoteDataSourceImpl();
  Dio dio = Dio();
/*
  @override
  Future<List<dynamic>> getLatestMoviesJson() async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/now_playing?api_key=${API_KEY}');
    return json.decode(jsonMovies.toString())['results'];
  }
*/
  @override
  Future<List<LatestMovieModel>> getLatestMovies() async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/now_playing?api_key=${API_KEY}');
    List<dynamic> movieJson = json.decode(jsonMovies.toString())['results'];
    return makeLatestMovieModels(movieJson);
  }

  List<LatestMovieModel> makeLatestMovieModels(List<dynamic> movieJson) {
    List<LatestMovieModel> latestMovieModels = [];
    movieJson.forEach((movie) => {
      latestMovieModels.add(
          LatestMovieModel.fromJson(movie)
      )
    });
    return latestMovieModels;
  }
/*
  @override
  Future<List<dynamic>> getTrailerJson(int movieId) async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/${movieId}/videos?api_key=${API_KEY}&language=en-US');
    return json.decode(jsonMovies.toString())['results'];
  }*/

  @override
  Future<String> getTrailerUrl(int movieId) async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/${movieId}/videos?api_key=${API_KEY}&language=en-US');
    List<dynamic> trailerJson = json.decode(jsonMovies.toString())['results'];
    return giveTrailerUrl(trailerJson);
  }

  String giveTrailerUrl(List<dynamic> trailerJson) {
    return trailerJson[0]['key'];
  }
  
}