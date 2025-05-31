import 'package:dio/dio.dart';

import 'api_result.dart';

Future<ApiResult<T>> handleApi<T>(Future<T> Function() request) async {
  try {
    final response = await request();
    return Success(response);
  } on DioException catch (e) {
    return Failure(e.toString());
  } catch (e) {
    return Failure(e.toString());
  }
}
