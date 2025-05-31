import 'package:expense_tracker_lite/core/helpers/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseValidator.validateAmount', () {
    test('returns error when value is null', () {
      final result = ExpenseValidator.validateAmount(null);
      expect(result, 'Please enter an amount');
    });

    test('returns error when value is empty', () {
      final result = ExpenseValidator.validateAmount('');
      expect(result, 'Please enter an amount');
    });

    test('returns error when value is not a number', () {
      final result = ExpenseValidator.validateAmount('abc');
      expect(result, 'Enter a valid amount greater than zero');
    });

    test('returns error when value is zero', () {
      final result = ExpenseValidator.validateAmount('0');
      expect(result, 'Enter a valid amount greater than zero');
    });

    test('returns error when value is negative', () {
      final result = ExpenseValidator.validateAmount('-5');
      expect(result, 'Enter a valid amount greater than zero');
    });

    test('returns null (no error) for valid amount', () {
      final result = ExpenseValidator.validateAmount('10.50');
      expect(result, null);
    });
  });
}
