import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  final IconData? icon;
  final TextStyle? textStyle;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyWidget({
    super.key,
    required this.message,
    this.icon,
    this.textStyle,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 64,
              color: Colors.grey[400],
            ),
          const SizedBox(height: 16),
          Text(
            message,
            style: textStyle ??
                TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
          ),
          if (onAction != null && actionText != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onAction,
              child: Text(actionText!),
            ),
          ],
        ],
      ),
    );
  }
}