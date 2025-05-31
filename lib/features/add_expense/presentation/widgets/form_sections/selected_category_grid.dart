import 'package:flutter/material.dart';

import '../../../data/models/expense_category.dart';
import '../selected_category_item.dart';

class SelectedCategoryGrid extends StatelessWidget {
  final List<ExpenseCategory> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const SelectedCategoryGrid({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: categories.length + 1,
      itemBuilder: (context, index) {
        if (index == categories.length) {
          return SelectedCategoryItem(
            icon: Icons.add,
            label: 'Add Category',
            color: Colors.grey,
            isSelected: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add new category functionality')),
              );
            },
          );
        }

        final category = categories[index];
        return SelectedCategoryItem(
          icon: category.icon,
          label: category.name,
          color: category.color,
          isSelected: selectedCategory == category.name,
          onTap: () => onCategorySelected(category.name),
        );
      },
    );
  }
}
