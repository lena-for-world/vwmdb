import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:vwmdb/rate/data/models/rate_model.dart';

class Testing {
  final String a;
  final int b;
  Testing(this.a, this.b);

  Map<String, dynamic> toJson() => {
      'a': a,
      'b': b,
  };
}

void main() async {

  var path = Directory.current.path;
  Hive.init(path);
  var box = await Hive.openBox('testBox');

  test('hive에 데이터를 저장할 수 있다.', () {
    box.put('testData', 'hi guys watch ke');
    print('test result: ${box.get('testData')}');
  });

  test('hive에 map도 그냥 저장되나?', () {
    box.put('testData2', {'key1': 'value', 'key2': 'value2'});
    print('result: ${box.get('testData2')}');
  });

  test('hive에 object도...?그냥 되나??', () {
    Testing testing = Testing('hi v', 1);
    String toStore = json.encode(testing);
    print(jsonEncode(testing).runtimeType);
    print(toStore.runtimeType);
    box.put('testData3', toStore);
    print('result: ${box.get('testData3')}');
  });

  test('hive에 Rate를 저장하고 가져올 수 있다', () {
    RateModel rateModel = RateModel(
      movieId: 284052, title: 'doctor poster', poster: 'test.png',
    );
    String toJson = json.encode(rateModel);
    print(toJson);
    box.put(284052, toJson);

    RateModel getIt = RateModel.fromJson(json.decode(box.get(284052)));
    print(getIt.review);
    print(getIt.title);
    print(getIt.poster);
  });
}