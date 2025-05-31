import 'package:dio/dio.dart';
import 'package:expense_tracker_lite/core/networking/api_constants.dart';


class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> getCurrencyRates(String baseCurrency) async {
    return _dio.get('${ApiConstants.baseUrl}$baseCurrency');
  }
}
