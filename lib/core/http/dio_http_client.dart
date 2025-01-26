import 'package:dio/dio.dart';

class DioHttpClient with DioMixin implements Dio {
  DioHttpClient() {
    options = BaseOptions(baseUrl: 'https://fakestoreapi.com/');
    httpClientAdapter = HttpClientAdapter();
  }
}
