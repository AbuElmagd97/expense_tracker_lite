part of 'add_expense_cubit.dart';

abstract class AddExpenseState {}

class CurrencyInitial extends AddExpenseState {}

class CurrencyLoading extends AddExpenseState {}

class CurrencyLoadingMore extends AddExpenseState {}

class CurrencySuccess extends AddExpenseState {
  final double convertedAmount;

  CurrencySuccess(this.convertedAmount);
}

class CurrencyFailure extends AddExpenseState {
  final String error;

  CurrencyFailure(this.error);
}

class CurrencyExpensesUpdated extends AddExpenseState {
  final List<Expense> expenses;
  CurrencyExpensesUpdated(this.expenses);
}
