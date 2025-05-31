import 'package:flutter/material.dart';

class IncomeExpenseSection extends StatelessWidget {
  final double income;
  final double expenses;

  const IncomeExpenseSection({
    super.key,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildIncomeExpenseItem(
            icon: Icons.arrow_downward,
            iconColor: Colors.white,
            backgroundColor: const Color(0xFF10B980).withOpacity(0.4),
            label: 'Income',
            amount: income,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildIncomeExpenseItem(
            icon: Icons.arrow_upward,
            iconColor: Colors.white,
            backgroundColor: const Color(0xFF10B980).withOpacity(0.4),
            label: 'Expenses',
            amount: expenses,
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeExpenseItem({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String label,
    required double amount,
  }) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '\$ ${amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
