import 'package:flutter/material.dart';

class Expense {
  final int? id;
  final String category;
  final double amount;
  final String currency; // original currency
  final double? convertedAmount; // converted to base currency (e.g., USD)
  final String time;
  final IconData? icon;
  final Color? color;

  Expense({
    this.id,
    required this.category,
    required this.amount,
    required this.currency,
    this.convertedAmount,
    required this.time,
    this.icon,
    this.color,
  });

  /// Convert Expense to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'currency': currency,
      'convertedAmount': convertedAmount,
      'time': time,
      'icon': icon?.codePoint,
      'color': color?.value,
    };
  }

  /// Create an Expense object from a Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      currency: map['currency'],
      convertedAmount: map['convertedAmount'],
      time: map['time'],
      icon: map['icon'] != null ? IconData(map['icon'], fontFamily: 'MaterialIcons') : null,
      color: map['color'] != null ? Color(map['color']) : null,
    );
  }



}
