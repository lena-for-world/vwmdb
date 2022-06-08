import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {

  Box? box;

  setUp(() async {
    var path = Directory.current.path;
    Hive.init(path);
    await Hive.openBox('testBox');
    box = Hive.box("testBox");
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
    print(box!.get("searched"));
  });
}