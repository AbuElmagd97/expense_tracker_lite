import 'package:flutter/material.dart';

import '../../../../../core/widgets/section_label.dart';
import '../../../data/models/expense_category.dart';
import '../../controller/expense_form_controller.dart';
import '../inputs/category_dropdown.dart';


class CategorySection extends StatelessWidget {
  final ExpenseFormController controller;
  final ValueChanged<String> onChanged;

  const CategorySection({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'Categories'),
        const SizedBox(height: 12),
        CategoryDropdown(
          selectedCategory: controller.selectedCategory,
          categories: ExpenseCategories.all,
          onChanged: onChanged,
        ),
      ],
    );
  }
}