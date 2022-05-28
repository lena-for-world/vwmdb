import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/network/api_key.dart';
import '../models/boxoffice_movie_model.dart';

abstract class BoxofficeMovieRemoteDataSource {
  Future<List<dynamic>> getBoxofficeMoviesJson();
  List<BoxofficeMovieModel> getBoxofficeMovies(List<dynamic> jsonMovies);
}

class BoxofficeMovieRemoteDataSourceImpl implements BoxofficeMovieRemoteDataSource {

  BoxofficeMovieRemoteDataSourceImpl();
  Dio dio = Dio();

  @override
  Future<List<dynamic>> getBoxofficeMoviesJson() async {
    final jsonMovies = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=${API_KEY}&language=en-US&page=1');
    return json.decode(jsonMovies.toString())['results'];
  }

  @override
  List<BoxofficeMovieModel> getBoxofficeMovies(List<dynamic> movieJson) {
    List<BoxofficeMovieModel> boxofficeMovieModels = [];
    movieJson.forEach((movie) => {
      boxofficeMovieModels.add(
          BoxofficeMovieModel.fromJson(movie)
      )
    });
    return boxofficeMovieModels;
  }

}