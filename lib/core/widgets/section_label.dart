import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const SectionLabel({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
    );
  }
}