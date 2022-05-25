
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/network/api_key.dart';
import '../../domain/entities/movie_entity.dart';
import '../models/latest_movie_model.dart';

abstract class LatestMovieRemoteDataSource {
  Future<List<LatestMovieModel>> getLatestMovies();
  Future<String> getTrailerUrl(int movieId);
}

class LatestMovieRemoteDataSourceImpl implements LatestMovieRemoteDataSource {

  LatestMovieRemoteDataSourceImpl();
  Dio dio = Dio();

  Future<List<dynamic>> getLatestMoviesJson() async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/now_playing?api_key.dart=ebdee09f8577cf2e8727490069a1db3f&page=1');
    return json.decode(jsonMovies.toString())['results'];
  }

  @override
  Future<List<LatestMovieModel>> getLatestMovies() async {
    // TODO: implement getLatestMovies
    List<LatestMovieModel> latestMovieModels = [];
    final movies = await getLatestMoviesJson();
    movies.forEach((movie) => {
      latestMovieModels.add(
          LatestMovieModel(
              movieId: movie['id'],
              title: movie['original_title'],
              poster: movie['poster_path'],
              year: movie['release_date']
          )
      )
    });
    return Future.value(latestMovieModels);
  }

  @override
  Future<Movie> getSingleMovieDetail(int) {
    // TODO: implement getSingleMovieDetail
    throw UnimplementedError();
  }

  Future<List<dynamic>> getTrailerJson() async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=${API_KEY}&language=en-US');
    return json.decode(jsonMovies.toString())['results'];
  }

  @override
  Future<String> getTrailerUrl(int movieId) async {
    // TODO: implement getTrailerUrl
    throw UnimplementedError();
  }
  
}