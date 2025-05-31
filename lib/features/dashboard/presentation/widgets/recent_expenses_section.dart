import 'package:expense_tracker_lite/features/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_item.dart';

class RecentExpensesSection extends StatelessWidget {
  const RecentExpensesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseCubit, AddExpenseState>(
      builder: (context, state) {
        final expenses = context.read<AddExpenseCubit>().expenses;
        if (state is CurrencyLoading && expenses.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (expenses.isEmpty) {
          return const Center(child: Text('No expenses found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: expenses.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == expenses.length) {
              if (state is CurrencyLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if ((context.read<AddExpenseCubit>()).hasMore) {
                return TextButton(
                  onPressed: () {
                    context.read<AddExpenseCubit>().loadMoreExpenses();
                  },
                  child: const Text('Load More'),
                );
              } else {
                return const SizedBox(height: 40);
              }
            }
            return ExpenseItem(expense: expenses[index]);
          },
        );
      },
    );
  }
}
