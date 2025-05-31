import 'package:flutter/material.dart';
import 'dart:io';
import '../../../../core/utils/expense_form_data.dart';
import '../../../../core/utils/date_time_format.dart';

class ExpenseFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String _selectedCategory = 'Entertainment';
  String _selectedCurrency = 'USD';
  final String _baseCurrency = 'USD';
  DateTime _selectedDate = DateTime.now();
  File? _receiptImage;

  ExpenseFormController() {
    dateController.text = formatDate(_selectedDate);
  }

  // Getters
  String get selectedCategory => _selectedCategory;

  String get selectedCurrency => _selectedCurrency;

  String get baseCurrency => _baseCurrency;

  DateTime get selectedDate => _selectedDate;

  File? get receiptImage => _receiptImage;

  // Setters
  void updateCategory(String category) {
    _selectedCategory = category;
  }

  void updateCurrency(String currency) {
    _selectedCurrency = currency;
  }

  void updateDate(DateTime date) {
    _selectedDate = date;
    dateController.text = formatDate(date);
  }

  void updateReceiptImage(File? image) {
    _receiptImage = image;
  }

  ExpenseFormData getFormData() {
    final amount = double.tryParse(amountController.text) ?? 0.0;
    return ExpenseFormData(
      selectedCategory: _selectedCategory,
      selectedCurrency: _selectedCurrency,
      baseCurrency: _baseCurrency,
      amount: amount,
      selectedDate: _selectedDate,
      receiptImage: _receiptImage,
    );
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    amountController.dispose();
    dateController.dispose();
  }
}
