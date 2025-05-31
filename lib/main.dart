import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(const MyApp());
}
