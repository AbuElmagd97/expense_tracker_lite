import 'package:expense_tracker_lite/core/helpers/db_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker_lite/features/add_expense/data/repos/currency_converter_repo.dart';
import 'package:expense_tracker_lite/features/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:expense_tracker_lite/core/networking/api_result.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyRepo extends Mock implements CurrencyRepository {}

void main() {
  late AddExpenseCubit cubit;
  late MockCurrencyRepo mockRepo;

  setUp(() {
    mockRepo = MockCurrencyRepo();
    cubit = AddExpenseCubit(mockRepo, FakeDatabaseHelper());
  });

  test('emits CurrencySuccess when conversion is successful', () async {
    when(() => mockRepo.convertCurrency(
          from: 'USD',
          to: 'EGP',
          amount: 10.0,
        )).thenAnswer((_) async => const Success(500.0)); // 10 * 50 EGP

    expectLater(
        cubit.stream,
        emitsInOrder([
          isA<CurrencyLoading>(),
          isA<CurrencySuccess>()
              .having((e) => e.convertedAmount, 'amount', 500.0),
        ]));

    await cubit.convertCurrency('USD', 'EGP', 10.0);
  });
}

class FakeDatabaseHelper implements DatabaseHelper {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
