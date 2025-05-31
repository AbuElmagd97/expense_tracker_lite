import 'package:flutter/material.dart';

class MonthFilterDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const MonthFilterDropdown({
    super.key,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox.shrink(),
        value: value,
        items: const [
          DropdownMenuItem(value: null, child: Text('This month')),
          DropdownMenuItem(value: 'January', child: Text('January')),
          DropdownMenuItem(value: 'All', child: Text('All')),
          // Add more months as needed
        ],
        onChanged: onChanged,
      ),
    );
  }
}
