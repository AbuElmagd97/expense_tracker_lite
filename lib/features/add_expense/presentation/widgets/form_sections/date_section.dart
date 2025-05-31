import 'package:expense_tracker_lite/features/add_expense/presentation/widgets/dialogs/date_picker_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/section_label.dart';
import '../../controller/expense_form_controller.dart';
import '../inputs/date_input_field.dart';

class DateSection extends StatelessWidget {
  final ExpenseFormController controller;
  final ValueChanged<DateTime> onDateChanged;

  const DateSection({
    super.key,
    required this.controller,
    required this.onDateChanged,
  });

  Future<void> _selectDate(BuildContext context) async {
    final date = await CustomDatePickerDialog.show(
      context,
      initialDate: controller.selectedDate,
    );

    if (date != null) {
      onDateChanged(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'Date'),
        const SizedBox(height: 12),
        DateInputField(
          controller: controller.dateController,
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}
