import 'package:expense_tracker_lite/core/extensions/navigation_extension.dart';
import 'package:expense_tracker_lite/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:expense_tracker_lite/features/dashboard/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Expenset.',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Password',
                controller: passwordController,
                isPassword: true,
                obscureText: obscurePassword,
                toggleVisibility: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forget password
                  },
                  child: const Text('Forget Password',
                      style: TextStyle(color: AppColors.primary)),
                ),
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                title: 'Login',
                onPressed: () {
                  // Handle login logic
                  context.push(const MainScreen());
                },
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Or Login with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/google.svg",height: 25,),
                label: const Text('Continue With Google'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/apple.svg",height: 25,),
                label: const Text('Continue With Apple'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Sign Up
                  },
                  child: RichText(
                      text: const TextSpan(
                    text: "Didn't have an account? ",
                    style: TextStyle(color: AppColors.greyText),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
