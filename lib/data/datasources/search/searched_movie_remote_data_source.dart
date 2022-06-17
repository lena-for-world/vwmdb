import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vwmdb/core/network/dio.dart';

import '../../../../core/network/api_key.dart';
import '../../models/search/searched_movie_model.dart';

abstract class SearchedRemoteDatasource {
  Future<List<SearchedMovieModel>> getSearchedResult(String input);
}

class SearchedRemoteDatasourceImpl implements SearchedRemoteDatasource {

  Dio dio = DioImpl().getInstance;

  @override
  Future<List<SearchedMovieModel>> getSearchedResult(String input) async {
    final movieResults = await dio.get('https://api.themoviedb.org/3/search/multi?api_key=${API_KEY}&language=en-US&page=1&include_adult=true&query=${input}');
    List<dynamic> movieJson = json.decode(movieResults.toString())['results'];
    return makeSearchedMovieModels(movieJson);
  }

  // NullException 처리
  // movieJson["result"]로 넘어오는 movie리스트에, 영화 말고도 tv, person 등 여러 타입이 있어서 걸러줘야 함
  // 안 거르면 String 기대했는데 null만 넘어왔어용 ㅜ 하는 에러 남
  List<SearchedMovieModel> makeSearchedMovieModels(List<dynamic> movieJson) {
    List<SearchedMovieModel> searchedMovieModels = [];
    movieJson.forEach((movie) {
      if(movie["media_type"] == "movie") {
        SearchedMovieModel convertedModel = SearchedMovieModel.fromJson(movie);
        if(convertedModel.movieId != null) {
          searchedMovieModels.add(convertedModel);
        }
      }
    });
    return searchedMovieModels;
  }
}