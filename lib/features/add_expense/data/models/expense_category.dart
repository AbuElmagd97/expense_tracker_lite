import 'package:flutter/material.dart';

class ExpenseCategory {
  final String name;
  final IconData icon;
  final Color color;

  const ExpenseCategory(this.name, this.icon, this.color);
}

class ExpenseCategories {
  static const List<ExpenseCategory> all = [
    ExpenseCategory('Groceries', Icons.shopping_cart, Colors.green),
    ExpenseCategory('Entertainment', Icons.movie, Colors.blue),
    ExpenseCategory('Bills', Icons.receipt_long, Colors.red),
    ExpenseCategory('Shopping', Icons.shopping_bag, Colors.pink),
    ExpenseCategory('News Paper', Icons.newspaper, Colors.purple),
    ExpenseCategory('Transport', Icons.directions_car, Colors.orange),
    ExpenseCategory('Rent', Icons.home, Colors.brown),
  ];

  static const List<String> currencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'CAD',
    'AUD'
  ];

  static ExpenseCategory findByName(String name) {
    return all.firstWhere(
      (category) => category.name == name,
      orElse: () => const ExpenseCategory('Other', Icons.category, Colors.grey),
    );
  }
}
