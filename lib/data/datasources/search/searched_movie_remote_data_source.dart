import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vwmdb/core/network/dio.dart';

import '../../../../core/network/api.dart';
import '../../models/search/searched_movie_model.dart';

abstract class SearchedRemoteDatasource {
  Future<List<SearchedMovieModel>> getSearchedResult(String input);
}

class SearchedRemoteDatasourceImpl implements SearchedRemoteDatasource {

  Dio dio = DioImpl().getInstance;

  @override
  Future<List<SearchedMovieModel>> getSearchedResult(String input) async {
    final movieResults = await dio.get('${API_SOURCE}/search/multi?api_key=${API_KEY}&language=en-US&page=1&include_adult=true&query=${input}');
    List<dynamic> movieJson = json.decode(movieResults.toString())['results'];
    return makeSearchedMovieModels(movieJson);
  }

  List<SearchedMovieModel> makeSearchedMovieModels(List<dynamic> movieJson) {
    List<SearchedMovieModel> searchedMovieModels = movieJson
        .where((movie) => movie["media_type"] == "movie")
        .toList()
        .map((movie) => SearchedMovieModel.fromJson(movie))
        .toList()
        .where((converted) => converted.movieId != null)
        .toList();
    return searchedMovieModels;
  }
}