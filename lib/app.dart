import 'package:expense_tracker_lite/core/di/dependency_injection.dart';
import 'package:expense_tracker_lite/features/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/routes/app_router.dart';
import 'core/theming/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddExpenseCubit>(
      create: (context) => getIt<AddExpenseCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}
