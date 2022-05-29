import 'dart:io';

import 'package:hive/hive.dart';

class HiveBox {

  HiveBox._privateConstructor();

  static var _box;

  static final HiveBox _instance = HiveBox._privateConstructor();

  factory HiveBox() {
    return _instance;
  }

  bool IfBoxOpened() {
    if(_box == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<Box> OpenTheBox(String boxName) async {
    var path = Directory.current.path;
    Hive.init(path);
    _box = await Hive.openBox(boxName);
    return box;
  }

  static get box => _box;
}