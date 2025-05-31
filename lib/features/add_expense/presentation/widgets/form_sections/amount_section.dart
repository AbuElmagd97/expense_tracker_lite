import 'package:flutter/material.dart';

import '../../../../../core/widgets/section_label.dart';
import '../../../data/models/expense_category.dart';
import '../../controller/expense_form_controller.dart';
import '../inputs/amount_input_field.dart';


class AmountSection extends StatelessWidget {
  final ExpenseFormController controller;
  final ValueChanged<String> onCurrencyChanged;

  const AmountSection({
    super.key,
    required this.controller,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'Amount'),
        const SizedBox(height: 12),
        AmountInputField(
          controller: controller.amountController,
          selectedCurrency: controller.selectedCurrency,
          currencies: ExpenseCategories.currencies,
          onCurrencyChanged: onCurrencyChanged,
        ),
      ],
    );
  }
}