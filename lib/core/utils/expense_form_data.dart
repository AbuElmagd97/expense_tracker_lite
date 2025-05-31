import 'dart:io';

class ExpenseFormData {
  final String selectedCategory;
  final String selectedCurrency;
  final String baseCurrency;
  final double amount;
  final DateTime selectedDate;
  final File? receiptImage;

  const ExpenseFormData({
    required this.selectedCategory,
    required this.selectedCurrency,
    required this.baseCurrency,
    required this.amount,
    required this.selectedDate,
    this.receiptImage,
  });
}