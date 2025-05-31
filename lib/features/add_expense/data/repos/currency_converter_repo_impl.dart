import 'package:expense_tracker_lite/core/networking/api_handler.dart';
import 'package:expense_tracker_lite/core/networking/api_result.dart';
import 'package:expense_tracker_lite/core/networking/api_service.dart';
import 'package:expense_tracker_lite/features/add_expense/data/repos/currency_converter_repo.dart';

class CurrencyConverterRepoImpl implements CurrencyRepository {
  final ApiService _apiService;

  CurrencyConverterRepoImpl(this._apiService);

  @override
  Future<ApiResult<double>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  }) {
    return handleApi<double>(() async {
      final response = await _apiService.getCurrencyRates(from);
      print("sd");
      if (response.statusCode == 200 && response.data['result'] == 'success') {
        final rates = response.data['rates'];
        if (rates != null && rates[to] != null) {
          final rate = (rates[to] as num).toDouble();
          return amount * rate;
        } else {
          throw Exception('Target Currency not found');
        }
      } else {
        throw Exception('Failed to fetch exchange rates');
      }
    });
  }
}
