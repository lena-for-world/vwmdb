import 'dart:io';

import 'package:hive/hive.dart';
import 'package:vwmdb/rate/presentation/viewmodels/hive_box.dart';

abstract class RateLocalSource {
  bool getIfMovieInWatchList(int movieId);
}

class RateLocalSourceImpl implements RateLocalSource {

  late final Box box;

  @override
  bool getIfMovieInWatchList(int movieId) {
    // TODO : getIfmovieinwatchlist
    // if(!HiveBox().IfBoxOpened()) {
    //   box = HiveBox().OpenTheBox("myMovies");
    // }
    box = Hive.box('myMovies');
    if(!box.containsKey(284052)) {
      return false;
    }
    return true;
  }

}