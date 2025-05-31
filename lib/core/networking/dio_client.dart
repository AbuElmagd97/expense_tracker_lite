import 'package:dio/dio.dart';

import 'api_constants.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.timeoutDuration,
        receiveTimeout: ApiConstants.timeoutDuration,
        responseType: ResponseType.json,
      ),
    );
  }

  static Dio get instance => DioClient().dio;
}
