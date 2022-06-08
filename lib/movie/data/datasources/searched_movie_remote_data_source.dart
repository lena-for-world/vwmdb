import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/searched_movie_model.dart';

abstract class SearchedRemoteDatasource {
  Future<List<dynamic>> getSearchedResult(String input);
  List<SearchedMovieModel> getSearchedMovies(List<dynamic> movieJson);
}

class SearchedRemoteDatasourceImpl implements SearchedRemoteDatasource {

  Dio dio = Dio();

  @override
  Future<List<dynamic>> getSearchedResult(String input) async {
    final movieResults = await dio.get('https://api.themoviedb.org/3/search/multi?api_key=ebdee09f8577cf2e8727490069a1db3f&language=en-US&page=1&include_adult=false&query=${input}');
    return json.decode(movieResults.toString())['results'];
  }

  @override
  List<SearchedMovieModel> getSearchedMovies(List<dynamic> movieJson) {
    List<SearchedMovieModel> searchedMovieModels = [];
    movieJson.forEach((movie) => {
      searchedMovieModels.add(
          SearchedMovieModel.fromJson(movie)
      )
    });
    return searchedMovieModels;
  }
}