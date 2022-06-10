import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:vwmdb/movie/data/datasources/rate/rate_local_source.dart';
import 'package:vwmdb/movie/data/models/rate/rate_model.dart';
import 'package:vwmdb/movie/data/repositories/rate/rate_repository.dart';

void main() {
  RateRepository? rateRepository;
  RateLocalSourceImpl? rateLocalSourceImpl;
  var box;

  setUp(() async {
    // rateLocalSource = RateLocalSourceImpl();
    //mockRateLocalSourceImpl = MockRateLocalSourceImpl();
    var path = Directory.current.path;
    Hive.init(path);
    await Hive.openBox('testBox');
    box = Hive.box("testBox");
    rateLocalSourceImpl = RateLocalSourceImpl(box);
    rateRepository = RateRepositoryImpl(rateLocalSourceImpl!);
    /*var hiveBox = HiveBox();
    if(!hiveBox.IfBoxOpened()) {
      box = hiveBox.OpenTheBox("testBox");
    }
    box = Hive.box("testBox");*/
  });

  test('시청 목록에 영화가 있는지 조회', () {
    int movieId = 284052;
    if(!box.containsKey(284052)) {
      return false;
    }
    return true;
  });

  test('시청 목록에 영화 등록되어 있으면 삭제, 등록 안 되어 있으면 추가', () {
    int movieId = 284052;
    // 가져오기
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    bool? beforeValue = rateModel.watchOrNot;
    // 변경
    if(rateModel.watchOrNot == null
      || rateModel.watchOrNot == false
    ) {
      rateModel.watchOrNot = true;
    } else {
      rateModel.watchOrNot = false;
    }
    // 변경된 모델 저장
    box.put(movieId, json.encode(rateModel));

    RateModel afterrateModel = RateModel.fromJson(json.decode(box.get(movieId)));

    print('${beforeValue} ${afterrateModel.watchOrNot}');
    expect(beforeValue != afterrateModel.watchOrNot, true);
  });

  test('영화에 내가 준 별점이 있는지 조회', () {
    int movieId = 284052;
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    if(rateModel.stars != null) {
      return true;
    } else {
      return false;
    }
  });

  test('영화에 내가 준 별점 조회', () {
    int movieId = 284052;
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    double? result = rateModel.stars;
    print(result);
  });

  test('영화에 내가 준 별점 저장', () {
    int movieId = 284052;
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));
    rateModel.stars = 2;
    box.put(movieId, json.encode(rateModel));

    RateModel afterrateModel = RateModel.fromJson(json.decode(box.get(movieId)));

    print('${afterrateModel.stars}');
    expect(afterrateModel.stars, equals(2));
  });

  test('영화에 내가 준 별점 삭제', () {
    int movieId = 284052;
    RateModel rateModel = RateModel.fromJson(json.decode(box.get(movieId)));

    var beforeValue = rateModel.stars;
    rateModel.stars = null;
    box.put(movieId, json.encode(rateModel));

    RateModel afterrateModel = RateModel.fromJson(json.decode(box.get(movieId)));

    print('${beforeValue} ${afterrateModel.stars}');
    box.keys.forEach((data) => print(data));
    expect(afterrateModel.stars, equals(null));
  });

  test('iterable key들을 모두 가져올 수 있는지', () {
    box.keys.forEach((data) => print(data));
  });
}