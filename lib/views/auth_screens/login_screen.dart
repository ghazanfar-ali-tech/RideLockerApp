import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/comonents/custom_text_field.dart';
import 'package:ride_locker_app/comonents/round_button.dart';
import 'package:ride_locker_app/providers/auth_providers/login_provider.dart';
import 'package:ride_locker_app/views/auth_screens/components/form_heading_text.dart';
import 'package:ride_locker_app/views/auth_screens/forgot_password_screen.dart';
import 'package:ride_locker_app/views/auth_screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.12),

              FormHeadingText(heading: 'Welcome Back'),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Sign in to continue your journey',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: screenHeight * 0.06),

              Consumer<LoginProvider>(
                builder: (context, provider, _) {
                  return Form(
                    key: loginformKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        customTextFormField(
                          controller: provider.emailController,
                          errorText: provider.emailError,
                          hint: 'Enter email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),

                        Consumer<LoginProvider>(
                          builder: (context, provider, _) {
                            return customTextFormField(
                              controller: provider.passwordController,
                              hint: 'Password',
                              prefixIcon: Icons.lock_outline,

                              suffixIcon: provider.isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,

                              obscureText: !provider.isPasswordVisible,

                              onSuffixTap: provider.togglePasswordVisibility,

                              errorText: provider.passwordError,
                            );
                          },
                        ),

                        SizedBox(height: screenHeight * 0.001),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<LoginProvider>(
                              builder: (context, provider, _) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: provider.rememberMe,
                                      onChanged: (_) =>
                                          provider.toggleRememberMe(),
                                      side: BorderSide(
                                        color: Colors.grey.shade600,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      activeColor: Colors.green,
                                    ),
                                    const Text(
                                      'Remember Me',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                );
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        RoundedButton(
                          text: 'Login',
                          isLoading: provider.isLoading,
                          onTap: () {
                            provider.loginWithEmail(context, loginformKey);
                          },
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
