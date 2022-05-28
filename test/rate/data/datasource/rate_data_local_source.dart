import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';
import 'package:vwmdb/rate/data/models/rate_model.dart';
import 'package:vwmdb/rate/data/repositories/rate_repository.dart';
import 'package:vwmdb/rate/presentation/viewmodels/hive_box.dart';

void main() {
  RateRepository? rateRepository;
  RateLocalSourceImpl? rateLocalSourceImpl;
  var path = Directory.current.path;
  Hive.init(path);

  setUp(() async {
    // rateLocalSource = RateLocalSourceImpl();
    //mockRateLocalSourceImpl = MockRateLocalSourceImpl();
    rateLocalSourceImpl = RateLocalSourceImpl();
    rateRepository = RateRepositoryImpl(rateLocalSourceImpl!);
    HiveBox.box = await Hive.openBox('testBox');
  });

  test('시청 목록에 영화가 있는지 조회', () {
    int movieId = 284052;
    if(!HiveBox.box.containsKey(284052)) {
      return false;
    }
    return true;
  });

  test('시청 목록에 영화 등록', () {
    int movieId = 284052;
    // 가져오기
    RateModel rateModel = RateModel.fromJson(json.decode(HiveBox.box.get(movieId)));
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
    HiveBox.box.put(movieId, json.encode(rateModel));

    RateModel afterrateModel = RateModel.fromJson(json.decode(HiveBox.box.get(movieId)));

    print('${beforeValue} ${afterrateModel.watchOrNot}');
    expect(beforeValue != afterrateModel.watchOrNot, true);
  });
}