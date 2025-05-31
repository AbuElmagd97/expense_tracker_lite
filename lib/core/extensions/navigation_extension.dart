import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  Future<T?> push<T>(Widget page) => Navigator.of(this).push<T>(
    MaterialPageRoute(builder: (_) => page),
  );

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName, {
        TO? result,
        Object? arguments,
      }) =>
      Navigator.of(this).pushReplacementNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String newRouteName,
      RoutePredicate predicate, {
        Object? arguments,
      }) =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(
        newRouteName,
        predicate,
        arguments: arguments,
      );

  void popUntil(RoutePredicate predicate) =>
      Navigator.of(this).popUntil(predicate);

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop<T>(result);
}