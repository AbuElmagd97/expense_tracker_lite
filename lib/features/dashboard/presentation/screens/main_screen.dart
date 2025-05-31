import 'package:expense_tracker_lite/core/di/dependency_injection.dart';
import 'package:expense_tracker_lite/core/extensions/navigation_extension.dart';
import 'package:expense_tracker_lite/features/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:expense_tracker_lite/features/add_expense/presentation/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_bottom_navigation_bar.dart';
import 'dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        onAddPressed: () => context.push(
          const AddExpenseScreen(),
        ),
      ),
    );
  }
}
