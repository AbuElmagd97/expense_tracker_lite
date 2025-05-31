import 'package:expense_tracker_lite/core/helpers/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseValidator.validateAmount', () {
    test('returns error when value is null', () {
      final result = AppValidator.validateAmount(null);
      expect(result, 'Please enter an amount');
    });

    test('returns error when value is empty', () {
      final result = AppValidator.validateAmount('');
      expect(result, 'Please enter an amount');
    });

    test('returns error when value is not a number', () {
      final result = AppValidator.validateAmount('abc');
      expect(result, 'Enter a valid amount greater than zero');
    });

    test('returns error when value is zero', () {
      final result = AppValidator.validateAmount('0');
      expect(result, 'Enter a valid amount greater than zero');
    });

    test('returns error when value is negative', () {
      final result = AppValidator.validateAmount('-5');
      expect(result, 'Enter a valid amount greater than zero');
    });

    test('returns null (no error) for valid amount', () {
      final result = AppValidator.validateAmount('10.50');
      expect(result, null);
    });
  });
}
