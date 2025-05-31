// import 'package:expense_tracker_lite/core/theming/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/utils/category_icons_colors.dart';
// import '../../../../core/utils/date_time_format.dart';
// import '../../../dashboard/data/models/expense_model.dart';
// import '../cubit/add_expense_cubit.dart';
//
// // Main Add Expense Screen
// class AddExpenseScreen extends StatefulWidget {
//   const AddExpenseScreen({super.key});
//
//   @override
//   State<AddExpenseScreen> createState() => _AddExpenseScreenState();
// }
//
// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _dateController = TextEditingController();
//
//   String _selectedCategory = 'Entertainment';
//   String _selectedCurrency = 'USD';
//   String _baseCurrency = 'USD'; // You can change this as needed
//   DateTime _selectedDate = DateTime.now();
//   File? _receiptImage;
//
//   // Category data with icons and colors
//   final List<ExpenseCategory> _categories = [
//     ExpenseCategory('Groceries', Icons.shopping_cart, Colors.green),
//     ExpenseCategory('Entertainment', Icons.movie, Colors.blue),
//     ExpenseCategory('Bills', Icons.receipt_long, Colors.red),
//     ExpenseCategory('Shopping', Icons.shopping_bag, Colors.pink),
//     ExpenseCategory('News Paper', Icons.newspaper, Colors.purple),
//     ExpenseCategory('Transport', Icons.directions_car, Colors.orange),
//     ExpenseCategory('Rent', Icons.home, Colors.brown),
//   ];
//
//   final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD'];
//
//   @override
//   void initState() {
//     super.initState();
//     _dateController.text = formatDate(_selectedDate);
//   }
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }
//
//
//
//   Future<void> _selectDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColors.primary,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text = formatDate(picked);
//       });
//     }
//   }
//
//   Future<void> _pickImage() async {
//     // In a real app, you would use image_picker package
//     // For demonstration, we'll simulate image selection
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Image picker would open here')),
//     );
//   }
//
//   double? _convertedAmount;
//
//   void _saveExpense() {
//     final amount = double.tryParse(_amountController.text);
//     if (!_formKey.currentState!.validate() || amount == null) return;
//
//     final needsConversion = _selectedCurrency != _baseCurrency;
//
//     if (needsConversion) {
//
//       // Just show loading message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Converting to USD, please wait...'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       // Convert from selected currency to USD
//       context.read<AddExpenseCubit>().convertCurrency(
//         _selectedCurrency, // FROM
//         _baseCurrency, // TO
//         amount,
//       );
//     } else {
//       // No conversion needed
//       _convertedAmount = amount;
//       _finalSave(amount);
//     }
//   }
//
// // Helper to save after conversion is done
//   Future<void> _finalSave(double amount) async {
//     // Find matching category
//     final matchedCategory = _categories.firstWhere(
//           (category) => category.name == _selectedCategory,
//       orElse: () => ExpenseCategory('Other', Icons.category, Colors.grey),
//     );
//     final newExpense = Expense(
//       currency: _selectedCurrency,
//       convertedAmount: _convertedAmount,
//       category: _selectedCategory,
//       amount: amount,
//       time: formattedTime(),
//       icon: matchedCategory.icon,
//       color: matchedCategory.color,
//     );
//
//     await context.read<AddExpenseCubit>().addExpense(newExpense);
//
//     if (mounted) {
//       final snackBarController = ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Expense saved successfully!'),
//           backgroundColor: Colors.green,
//           duration: Duration(seconds: 2), // optional
//         ),
//       );
//
//       // Wait for the snackbar to close before popping
//       await snackBarController.closed;
//
//       if (mounted) {
//         Navigator.pop(context);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AddExpenseCubit, AddExpenseState>(
//       listener: (context, state) {
//         if (state is CurrencySuccess) {
//             _convertedAmount = state.convertedAmount;
//             _finalSave(double.parse(_amountController.text));
//         } else if (state is CurrencyFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Currency conversion failed: ${state.error}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           surfaceTintColor: Colors.white,
//           title: const Text(
//             'Add Expense',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Category Section
//                       const SectionLabel(text: 'Categories'),
//                       const SizedBox(height: 12),
//                       CategoryDropdown(
//                         selectedCategory: _selectedCategory,
//                         categories: _categories,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedCategory = value;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 24),
//
//                       // Amount Section
//                       const SectionLabel(text: 'Amount'),
//                       const SizedBox(height: 12),
//                       AmountInputField(
//                         controller: _amountController,
//                         selectedCurrency: _selectedCurrency,
//                         currencies: _currencies,
//                         onCurrencyChanged: (value) {
//                           setState(() {
//                             _selectedCurrency = value;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 24),
//
//                       // Date Section
//                       const SectionLabel(text: 'Date'),
//                       const SizedBox(height: 12),
//                       DateInputField(
//                         controller: _dateController,
//                         onTap: _selectDate,
//                       ),
//                       const SizedBox(height: 24),
//
//                       // Receipt Section
//                       const SectionLabel(text: 'Attach Receipt'),
//                       const SizedBox(height: 12),
//                       ReceiptUploadField(onTap: _pickImage),
//                       const SizedBox(height: 32),
//
//                       // Categories Grid
//                       const SectionLabel(text: 'Categories'),
//                       const SizedBox(height: 16),
//                       CategoryGrid(
//                         categories: _categories,
//                         selectedCategory: _selectedCategory,
//                         onCategorySelected: (category) {
//                           setState(() {
//                             _selectedCategory = category;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Save Button
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: BlocBuilder<AddExpenseCubit, AddExpenseState>(
//                   builder: (context, state) {
//                     final isLoading = state is CurrencyLoading;
//                     return SaveButton(
//                       onPressed: _saveExpense,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Reusable Components
//
// class SectionLabel extends StatelessWidget {
//   final String text;
//
//   const SectionLabel({super.key, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//         color: Colors.black87,
//       ),
//     );
//   }
// }
//
// class CategoryDropdown extends StatelessWidget {
//   final String selectedCategory;
//   final List<ExpenseCategory> categories;
//   final ValueChanged<String> onChanged;
//
//   const CategoryDropdown({
//     super.key,
//     required this.selectedCategory,
//     required this.categories,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: DropdownButtonFormField<String>(
//         value: selectedCategory,
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           border: InputBorder.none,
//         ),
//         items: categories.map((category) {
//           return DropdownMenuItem<String>(
//             value: category.name,
//             child: Row(
//               children: [
//                 Icon(category.icon, color: category.color, size: 20),
//                 const SizedBox(width: 12),
//                 Text(category.name),
//               ],
//             ),
//           );
//         }).toList(),
//         onChanged: (value) => onChanged(value!),
//         icon: const Icon(Icons.keyboard_arrow_down),
//       ),
//     );
//   }
// }
//
// class AmountInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final String selectedCurrency;
//   final List<String> currencies;
//   final ValueChanged<String> onCurrencyChanged;
//
//   const AmountInputField({
//     super.key,
//     required this.controller,
//     required this.selectedCurrency,
//     required this.currencies,
//     required this.onCurrencyChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Row(
//         children: [
//           // Currency Dropdown
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: DropdownButton<String>(
//               value: selectedCurrency,
//               underline: const SizedBox(),
//               items: currencies.map((currency) {
//                 return DropdownMenuItem<String>(
//                   value: currency,
//                   child: Text(currency),
//                 );
//               }).toList(),
//               onChanged: (value) => onCurrencyChanged(value!),
//             ),
//           ),
//           Container(
//             width: 1,
//             height: 40,
//             color: Colors.grey[300],
//           ),
//           // Amount Input
//           Expanded(
//             child: TextFormField(
//               controller: controller,
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//               ],
//               decoration: const InputDecoration(
//                 hintText: '\$0.00',
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 border: InputBorder.none,
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter an amount';
//                 }
//                 if (double.tryParse(value) == null) {
//                   return 'Please enter a valid amount';
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onTap;
//
//   const DateInputField({
//     super.key,
//     required this.controller,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: TextFormField(
//         controller: controller,
//         readOnly: true,
//         onTap: onTap,
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           border: InputBorder.none,
//           suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please select a date';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
//
// class ReceiptUploadField extends StatelessWidget {
//   final VoidCallback onTap;
//
//   const ReceiptUploadField({super.key, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey[300]!),
//         ),
//         child: const Row(
//           children: [
//             SizedBox(width: 16),
//             Text(
//               'Upload Receipt',
//               style: TextStyle(color: Colors.grey, fontSize: 16),
//             ),
//             Spacer(),
//             Icon(Icons.camera_alt, color: Colors.grey),
//             SizedBox(width: 12),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryGrid extends StatelessWidget {
//   final List<ExpenseCategory> categories;
//   final String selectedCategory;
//   final ValueChanged<String> onCategorySelected;
//
//   const CategoryGrid({
//     super.key,
//     required this.categories,
//     required this.selectedCategory,
//     required this.onCategorySelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         childAspectRatio: 1,
//         crossAxisSpacing: 1,
//         mainAxisSpacing: 1,
//       ),
//       itemCount: categories.length + 1,
//       // +1 for "Add Category" button
//       itemBuilder: (context, index) {
//         if (index == categories.length) {
//           return CategoryItem(
//             icon: Icons.add,
//             label: 'Add Category',
//             color: Colors.grey,
//             isSelected: false,
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Add new category functionality')),
//               );
//             },
//           );
//         }
//
//         final category = categories[index];
//         return CategoryItem(
//           icon: category.icon,
//           label: category.name,
//           color: category.color,
//           isSelected: selectedCategory == category.name,
//           onTap: () => onCategorySelected(category.name),
//         );
//       },
//     );
//   }
// }
//
// class CategoryItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const CategoryItem({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: isSelected ? color : color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: isSelected ? Border.all(color: color, width: 2) : null,
//             ),
//             child: Icon(
//               icon,
//               color: isSelected ? Colors.white : color,
//               size: 24,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 10,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//               color: isSelected ? color : Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SaveButton extends StatelessWidget {
//   final VoidCallback onPressed;
//
//   const SaveButton({super.key, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF4285F4),
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: const Text(
//           'Save',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Data Models
// class ExpenseCategory {
//   final String name;
//   final IconData icon;
//   final Color color;
//
//   ExpenseCategory(this.name, this.icon, this.color);
// }
// screens/add_expense_screen.dart
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

  Future<void> _saveExpense(ExpenseFormData formData, double convertedAmount) async {
    final newExpense = _createExpenseFromFormData(formData, convertedAmount);

    await context.read<AddExpenseCubit>().addExpense(newExpense);

    if (mounted) {
      await _showSuccessAndNavigateBack();
    }
  }

  Expense _createExpenseFromFormData(ExpenseFormData formData, double convertedAmount) {
    final matchedCategory = ExpenseCategories.findByName(formData.selectedCategory);

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




