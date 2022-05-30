import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';
import 'package:vwmdb/rate/data/repositories/rate_repository.dart';

void main() {

  RateRepository? rateRepository;
  RateLocalSourceImpl? rateLocalSourceImpl;
  var box;

  setUp(() async {
    var path = Directory.current.path;
    Hive.init(path);
    await Hive.openBox('testBox');
    box = Hive.box("testBox");
    rateLocalSourceImpl = RateLocalSourceImpl(box);
    rateRepository = RateRepositoryImpl(rateLocalSourceImpl!);
  });

  // TODO : repository를 사용하는 곳에서 box 가져오기
  test('시청 목록에 영화가 있는지 조회', () {

  });

  test('영화 시청 목록에 등록', () {

  });

  test('영화 시청 목록에서 삭제', () {

  });

  test('영화에 내가 준 별점이 있는지 조회', () {

  });

  test('영화에 내가 준 별점 조회', () {

  });

  test('영화에 내가 준 별점 저장', () {

  });

  test('영화에 내가 준 별점 삭제', () {

  });
}