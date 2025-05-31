import 'package:flutter/material.dart';
import '../../../data/models/expense_category.dart';

class CategoryDropdown extends StatelessWidget {
  final String selectedCategory;
  final List<ExpenseCategory> categories;
  final ValueChanged<String> onChanged;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
        items: categories.map((category) {
          return DropdownMenuItem<String>(
            value: category.name,
            child: Row(
              children: [
                Icon(category.icon, color: category.color, size: 20),
                const SizedBox(width: 12),
                Text(category.name),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) => onChanged(value!),
        icon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }
}