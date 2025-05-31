import 'package:flutter/material.dart';

import '../../../../../core/widgets/section_label.dart';
import '../../../data/models/expense_category.dart';
import 'selected_category_grid.dart';


class SelectedCategoryGridSection extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const SelectedCategoryGridSection({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'Categories'),
        const SizedBox(height: 16),
        SelectedCategoryGrid(
          categories: ExpenseCategories.all,
          selectedCategory: selectedCategory,
          onCategorySelected: onCategorySelected,
        ),
      ],
    );
  }
}