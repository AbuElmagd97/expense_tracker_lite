import 'package:flutter/material.dart';

import '../../data/models/expense_model.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Enhanced circular icon container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: expense.color?.withOpacity(0.1),
            ),
            child: Icon(
              expense.icon,
              color: expense.color,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),

          // Category and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Manually',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Amount and time
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Original amount
              Text(
                '- ${expense.amount.toStringAsFixed(0)} ${expense.currency}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 2),

              // Converted amount (if available)
              if (expense.convertedAmount != null)
                Text(
                  '= \$${expense.convertedAmount!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),

              const SizedBox(height: 2),

              // Time
              Text(
                expense.time,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
