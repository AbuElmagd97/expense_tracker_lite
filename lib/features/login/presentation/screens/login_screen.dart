import 'package:flutter/material.dart';
import 'package:expense_tracker_lite/core/extensions/navigation_extension.dart';
import 'package:expense_tracker_lite/core/theming/app_colors.dart';
import 'package:expense_tracker_lite/core/widgets/primary_button.dart';
import 'package:expense_tracker_lite/features/dashboard/presentation/screens/main_screen.dart';

import '../widgets/divider_with_text.dart';
import '../widgets/email_field.dart';
import '../widgets/forget_password_button.dart';
import '../widgets/login_title.dart';
import '../widgets/logo.dart';
import '../widgets/password_field.dart';
import '../widgets/sign_up_prompt.dart';
import '../widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  final String validEmail = 'test@example.com';
  final String validPassword = '123456';

  void _attemptLogin() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == validEmail &&
          passwordController.text == validPassword) {
        context.push(const MainScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Logo(),
                const SizedBox(height: 40),
                const LoginTitle(),
                const SizedBox(height: 20),
                EmailField(controller: emailController),
                const SizedBox(height: 10),
                PasswordField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  onToggleVisibility: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
                const ForgotPasswordButton(),
                const SizedBox(height: 10),
                PrimaryButton(
                  title: 'Login',
                  onPressed: _attemptLogin,
                ),
                const SizedBox(height: 20),
                const DividerWithText(),
                const SizedBox(height: 20),
                const SocialLoginButtons(),
                const SizedBox(height: 30),
                const SignUpPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
