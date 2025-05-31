import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_time_format.dart';
import '../../../../core/utils/expense_form_data.dart';
import '../../../dashboard/data/models/expense_model.dart';
import '../../data/models/expense_category.dart';
import '../controller/expense_form_controller.dart';
import '../cubit/add_expense_cubit.dart';
import '../widgets/expense_form.dart';
import '../widgets/custom_app_bar.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  late final ExpenseFormController _formController;

  @override
  void initState() {
    super.initState();
    _formController = ExpenseFormController();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  void _handleSaveExpense(ExpenseFormData formData) {
    final needsConversion = formData.selectedCurrency != formData.baseCurrency;

    if (needsConversion) {
      _showConversionMessage();
      context.read<AddExpenseCubit>().convertCurrency(
            formData.selectedCurrency,
            formData.baseCurrency,
            formData.amount,
          );
    } else {
      _saveExpense(formData, formData.amount);
    }
  }

  void _showConversionMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Converting to USD, please wait...'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _saveExpense(
      ExpenseFormData formData, double convertedAmount) async {
    final newExpense = _createExpenseFromFormData(formData, convertedAmount);

    await context.read<AddExpenseCubit>().addExpense(newExpense);

    if (mounted) {
      await _showSuccessAndNavigateBack();
    }
  }

  Expense _createExpenseFromFormData(
      ExpenseFormData formData, double convertedAmount) {
    final matchedCategory =
        ExpenseCategories.findByName(formData.selectedCategory);

    return Expense(
      currency: formData.selectedCurrency,
      convertedAmount: convertedAmount,
      category: formData.selectedCategory,
      amount: formData.amount,
      time: formattedTime(),
      icon: matchedCategory.icon,
      color: matchedCategory.color,
    );
  }

  Future<void> _showSuccessAndNavigateBack() async {
    final snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expense saved successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    await snackBarController.closed;

    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _showErrorMessage(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Currency conversion failed: $error'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseCubit, AddExpenseState>(
      listener: (context, state) {
        if (state is CurrencySuccess) {
          final formData = _formController.getFormData();
          _saveExpense(formData, state.convertedAmount);
        } else if (state is CurrencyFailure) {
          _showErrorMessage(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(title: 'Add Expense'),
        body: ExpenseForm(
          controller: _formController,
          onSave: _handleSaveExpense,
        ),
      ),
    );
  }
}
