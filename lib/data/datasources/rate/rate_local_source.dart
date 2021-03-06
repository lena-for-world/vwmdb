import 'dart:convert';

import 'package:hive/hive.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../models/rate/rate_model.dart';

abstract class RateLocalSource {
  void postCheckOrUncheckMovieInWatchList(int movieId);
  bool getIfMovieRated(int moviedId);
  double getMovieRated(int movieId);
  bool getIfInWatchList(int movieId);
  void postMovieRating(int movieId, double rating);
  void deleteMovieRated(int movieId);
  void saveMovieIn(Movie movie);
  Iterable<dynamic> getAllMovieKeys();
  bool getIfInRatedList(int movieId);
  RateModel getSingleRateValue(int movieId);
}

class RateLocalSourceImpl implements RateLocalSource {

  late final Box box;

  RateLocalSourceImpl(this.box);

  @override
  void deleteMovieRated(int movieId) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    rateModel.stars = null;
    box.put(movieId, json.encode(rateModel));
  }

  @override
  bool getIfMovieRated(int movieId) {
    if(!box.containsKey(movieId)) {
      return false;
    }
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    if(rateModel.stars != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  double getMovieRated(int movieId) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    return rateModel.stars!;
  }

  @override
  void postCheckOrUncheckMovieInWatchList(int movieId) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    if(rateModel.watchOrNot == null || rateModel.watchOrNot == false) {
      rateModel.watchOrNot = true;
    } else {
      rateModel.watchOrNot = false;
    }
    box.put(movieId, json.encode(rateModel));
  }

  @override
  void postMovieRating(int movieId, double rating) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    rateModel.stars = rating;
    box.put(movieId, json.encode(rateModel));
  }

  @override
  bool getIfInWatchList(int movieId) {
    if(!box.containsKey(movieId)) {
      return false;
    }
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    if(rateModel.watchOrNot == null || rateModel.watchOrNot == false) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void saveMovieIn(Movie model) {
    if(!box.containsKey(model.movieId)) {
      RateModel rateModel = RateModel(movieId: model.movieId, title: model.title, poster: model.poster);
      box.put(model.movieId, json.encode(rateModel));
    }
  }

  @override
  Iterable<dynamic> getAllMovieKeys() {
    return box.keys;
  }

  @override
  bool getIfInRatedList(int movieId) {
    if(!box.containsKey(movieId)) {
      return false;
    }
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    if(rateModel.stars == null || rateModel.stars == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  RateModel getSingleRateValue(int movieId) {
    return RateModel.fromJson(json.decode(box.get(movieId)));
  }

}