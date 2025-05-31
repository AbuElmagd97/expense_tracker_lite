import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../add_expense/presentation/cubit/add_expense_cubit.dart';
import '../widgets/dashboard_background.dart';
import '../widgets/header_section.dart';
import '../widgets/recent_expenses_section.dart';
import '../widgets/section_header.dart';
import '../widgets/total_balance_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _filterMonth;

  @override
  void initState() {
    _loadInitialExpenses();
    super.initState();
  }

  void _loadInitialExpenses() {
    context.read<AddExpenseCubit>().loadExpensesPaged();
  }

  void _onFilterChanged(String? newFilterMonth) {
    setState(() {
      _filterMonth = newFilterMonth;
    });
    context.read<AddExpenseCubit>().resetPagination();
    context
        .read<AddExpenseCubit>()
        .loadExpensesPaged(filterMonth: _filterMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          const DashboardBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  HeaderSection(
                    filterMonth: _filterMonth,
                    onFilterChanged: _onFilterChanged,
                  ),
                  const SizedBox(height: 30),
                  const TotalBalanceCard(balance: 2548.00),
                  const SizedBox(height: 30),
                  const SectionHeader(),
                  const SizedBox(height: 10),
                  const Expanded(
                    child: RecentExpensesSection(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
