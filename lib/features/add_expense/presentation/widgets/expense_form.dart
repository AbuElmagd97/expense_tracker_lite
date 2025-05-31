import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/expense_form_data.dart';
import '../controller/expense_form_controller.dart';
import '../cubit/add_expense_cubit.dart';
import 'form_sections/amount_section.dart';
import 'form_sections/selected_category_grid_section.dart';
import 'form_sections/category_section.dart';
import 'form_sections/date_section.dart';
import 'form_sections/receipt_section.dart';
import 'save_button.dart';

class ExpenseForm extends StatefulWidget {
  final ExpenseFormController controller;
  final Function(ExpenseFormData) onSave;

  const ExpenseForm({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  void _handleSave() {
    if (!widget.controller.validate()) return;

    final amount = double.tryParse(widget.controller.amountController.text);
    if (amount == null) return;

    widget.onSave(widget.controller.getFormData());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategorySection(
                    controller: widget.controller,
                    onChanged: (category) {
                      setState(() {
                        widget.controller.updateCategory(category);
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  AmountSection(
                    controller: widget.controller,
                    onCurrencyChanged: (currency) {
                      setState(() {
                        widget.controller.updateCurrency(currency);
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  DateSection(
                    controller: widget.controller,
                    onDateChanged: (date) {
                      setState(() {
                        widget.controller.updateDate(date);
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ReceiptSection(
                    onImagePicked: (image) {
                      setState(() {
                        widget.controller.updateReceiptImage(image);
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  SelectedCategoryGridSection(
                    selectedCategory: widget.controller.selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        widget.controller.updateCategory(category);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<AddExpenseCubit, AddExpenseState>(
              builder: (context, state) {
                final isLoading = state is CurrencyLoading;
                return SaveButton(
                  onPressed: isLoading ? null : _handleSave,
                  isLoading: isLoading,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
