

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';
import 'package:vwmdb/rate/data/repositories/rate_repository.dart';
import 'package:vwmdb/rate/domain/usecases/rate_usecase.dart';

class MockRateRepository extends Mock implements RateRepository{}

@GenerateMocks([MockRateRepository])
void main() {
  RateUsecase? rateUsecase;
  RateRepository? rateRepository;
  RateLocalSource rateLocalSource;
  var box;

  setUp(() async {
    var path = Directory.current.path;
    Hive.init(path);
    await Hive.openBox('testBox');
    box = Hive.box("testBox");

    rateLocalSource = RateLocalSourceImpl(box);
    rateRepository = RateRepositoryImpl(rateLocalSource);
    //rateRepository = MockRateRepository();
    rateUsecase = RateUsecase(rateRepository!);
  });

  test('get movie rating ', () {
//    when(rateRepository!.getIfMovieRated(284052)).thenAnswer((_)  => false);
    final result = rateUsecase!.getMovieRated(284052);
    print(result);
//    verify(rateRepository!.getIfMovieRated(284052));
  });
}