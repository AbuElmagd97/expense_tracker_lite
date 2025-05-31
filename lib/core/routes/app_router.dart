import 'package:expense_tracker_lite/features/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../features/add_expense/presentation/screens/add_expense_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/dashboardScreen':
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case '/addExpenseScreen':
        return MaterialPageRoute(
          builder: (_) => const AddExpenseScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
