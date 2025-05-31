import 'package:expense_tracker_lite/core/helpers/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_result.dart';
import '../../../dashboard/data/models/expense_model.dart';
import '../../data/repos/currency_converter_repo.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final CurrencyRepository repository;
  final DatabaseHelper dbHelper;

  static const int _pageSize = 10;
  int _currentPage = 0;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  String? _filterMonth;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  AddExpenseCubit(this.repository, this.dbHelper) : super(CurrencyInitial());

  /// Load first page with optional month filter ("YYYY-MM")
  Future<void> loadExpensesPaged({String? filterMonth}) async {
    _filterMonth = filterMonth;
    _currentPage = 0;
    _hasMore = true;
    _expenses.clear();

    emit(CurrencyLoading());

    final newExpenses = await dbHelper.getExpensesPaged(
      offset: 0,
      limit: _pageSize,
      filterMonth: _filterMonth,
    );

    _expenses.addAll(newExpenses);
    _hasMore = newExpenses.length == _pageSize;

    emit(CurrencyExpensesUpdated(List.from(_expenses)));
  }

  /// Load more expenses for pagination (infinite scroll or "Load More" button)
  Future<void> loadMoreExpenses() async {
    if (!_hasMore) return;

    _currentPage++;
    emit(CurrencyLoadingMore());

    final newExpenses = await dbHelper.getExpensesPaged(
      offset: _currentPage * _pageSize,
      limit: _pageSize,
      filterMonth: _filterMonth,
    );

    _expenses.addAll(newExpenses);
    _hasMore = newExpenses.length == _pageSize;

    emit(CurrencyExpensesUpdated(List.from(_expenses)));
  }

  Future<void> convertCurrency(String from, String to, double amount) async {
    emit(CurrencyLoading());
    final result = await repository.convertCurrency(
      from: from,
      to: to,
      amount: amount,
    );

    if (result is Success<double>) {
      emit(CurrencySuccess(result.data));
    } else {
      emit(CurrencyFailure((result as Failure).error));
    }
  }

  /// Insert new expense and reload the first page
  Future<void> addExpense(Expense expense) async {
    await dbHelper.insertExpense(expense);
    // Reload first page with current filter
    await loadExpensesPaged(filterMonth: _filterMonth);
  }

  Future<void> clearExpenses() async {
    await dbHelper.clearExpenses();
    _expenses.clear();
    emit(CurrencyExpensesUpdated(List.from(_expenses)));
  }

  void resetPagination() {
    _currentPage = 0;
    _expenses.clear();
    _hasMore = true;
    emit(CurrencyExpensesUpdated(List.from(_expenses)));
  }
}

