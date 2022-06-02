import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:vwmdb/rate/presentation/viewmodels/hive_box.dart';

import '../models/rate_model.dart';

abstract class RateLocalSource {
  bool getIfMovieInLocalStore(int movieId);
  void postCheckOrUncheckMovieInWatchList(int movieId);
  bool getIfMovieRated(int moviedId);
  int getMovieRated(int movieId);
  bool getIfInWatchList(int movieId);
  void postMovieRating(int movieId, int rating);
  void deleteMovieRated(int movieId);
}

class RateLocalSourceImpl implements RateLocalSource {

  late final Box box;

  RateLocalSourceImpl(this.box);

  @override
  bool getIfMovieInLocalStore(int movieId) {
    // TODO : getIfmovieinwatchlist -- key 유무만 확인하고 있으므로 이걸로 시청 목록 존재여부를 파악할 수는 없음
    if(!box.containsKey(movieId)) {
      return false;
    }
    return true;
  }

  @override
  void deleteMovieRated(int movieId) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    rateModel.stars = null;
    box.put(movieId, json.encode(rateModel));
  }

  @override
  bool getIfMovieRated(int movieId) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    if(rateModel.stars != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int getMovieRated(int movieId) {
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
  void postMovieRating(int movieId, int rating) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    rateModel.stars = rating;
    box.put(movieId, json.encode(rateModel));
  }

  @override
  bool getIfInWatchList(int movieId) {
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    if(rateModel.watchOrNot == null || rateModel.watchOrNot == false) {
      return false;
    } else {
      return true;
    }
  }

}