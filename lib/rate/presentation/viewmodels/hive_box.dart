class HiveBox {

  static var box;

  HiveBox._privateConstructor();
  static final HiveBox _instance = HiveBox._privateConstructor();
  factory HiveBox() {
    return _instance;
  }
}