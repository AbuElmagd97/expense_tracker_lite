import '../../../../core/networking/api_result.dart';

abstract class CurrencyRepository {
  Future<ApiResult<double>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  });
}
