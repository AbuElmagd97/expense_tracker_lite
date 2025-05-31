import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Login',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}