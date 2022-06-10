import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:vwmdb/movie/data/datasources/search/searched_movie_local_source.dart';

void main() async {

  Box? box;
  SearchedMovieLocalSourceImpl? searchedMovieLocalSourceImpl;

  setUp(() async {
    var path = Directory.current.path;
    Hive.init(path);
    await Hive.openBox('testBox');
    box = Hive.box("testBox");
    searchedMovieLocalSourceImpl = SearchedMovieLocalSourceImpl(box!);
  });

  test('box에 검색 기록 저장', () {

    List<String> dd = [];
    dd.add("temp");

    box!.put("searched", dd);

    final res = box!.get("searched");

    print(res);

    List<String> sfs = box!.get("searched");
    sfs.add("wefed");
    box!.put("searched", sfs);
    print(box!.get("searched").runtimeType);
  });

  test('hive searched movie test', (){
    String input = "loona";
    searchedMovieLocalSourceImpl!.saveSearchedKeyInLocalStoreIfNotExists();
    searchedMovieLocalSourceImpl!.saveSearchedItem(input);
    print(searchedMovieLocalSourceImpl!.getAllSearchedItems().runtimeType);
  });

  test('hive empty list save test', (){
    String input = "loona";
    List<String> list= [];
    box!.put('testempty', list);
    print(box!.get('testempty').runtimeType);
  });
}