import 'package:dio/dio.dart';

class DioImpl {
  static Dio? _dio;
  Dio get getInstance {
    if (_dio == null) {
      print('first create Dio');
      _dio = Dio();
    }
    return _dio!;
  }
}