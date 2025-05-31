import 'package:expense_tracker_lite/core/helpers/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCurrency;
  final List<String> currencies;
  final ValueChanged<String> onCurrencyChanged;

  const AmountInputField({
    super.key,
    required this.controller,
    required this.selectedCurrency,
    required this.currencies,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          // Currency Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: selectedCurrency,
              underline: const SizedBox(),
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) => onCurrencyChanged(value!),
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          // Amount Input
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: const InputDecoration(
                hintText: '\$0.00',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: InputBorder.none,
              ),
              validator: ExpenseValidator.validateAmount,
            ),
          ),
        ],
      ),
    );
  }
}
