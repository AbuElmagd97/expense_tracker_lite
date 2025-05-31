import 'package:dio/dio.dart';
import 'package:expense_tracker_lite/core/helpers/db_helper.dart';
import 'package:expense_tracker_lite/core/networking/api_service.dart';
import 'package:expense_tracker_lite/features/add_expense/data/repos/currency_converter_repo.dart';
import 'package:expense_tracker_lite/features/add_expense/data/repos/currency_converter_repo_impl.dart';
import 'package:expense_tracker_lite/features/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:get_it/get_it.dart';

import '../networking/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register dio instance
  getIt.registerLazySingleton<Dio>(() => DioClient.instance);

  // Register API services
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<Dio>()),
  );

  // Register repositories
  getIt.registerLazySingleton<CurrencyRepository>(
    () => CurrencyConverterRepoImpl(getIt<ApiService>()),
  );

  // Register DB Helper
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Register Cubit as factory
  getIt.registerFactory<AddExpenseCubit>(
    () => AddExpenseCubit(
      getIt<CurrencyRepository>(),
      getIt<DatabaseHelper>(),
    ),
  );
}
