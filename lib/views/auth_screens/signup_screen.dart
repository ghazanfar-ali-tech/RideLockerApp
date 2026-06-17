import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/components/custom_text_field.dart';
import 'package:ride_locker_app/components/round_button.dart';
import 'package:ride_locker_app/providers/auth_providers/signup_provider.dart';
import 'package:ride_locker_app/views/auth_screens/components/form_heading_text.dart';
import 'package:ride_locker_app/views/auth_screens/components/form_subheading_text.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final GlobalKey<FormState> sginUpformKey = GlobalKey<FormState>();

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
              SizedBox(height: screenHeight * 0.06),

              FormHeadingText(heading: 'Create Account'),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Join us and start tracking',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: screenHeight * 0.05),
              Consumer<SignupProvider>(
                builder: (context, signupProvider, child) {
                  return Form(
                    key: sginUpformKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Full Name',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        customTextFormField(
                          hint: 'Enter name',
                          controller: signupProvider.nameController,
                          prefixIcon: Icons.person_outline,
                          errorText: signupProvider.nameError,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Phone',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        customTextFormField(
                          controller: signupProvider.phoneNumberController,
                          hint: '1234 5678 9012 3456',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          errorText: signupProvider.phoneNumberError,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        customTextFormField(
                          controller: signupProvider.emailController,
                          hint: 'Enter email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          errorText: signupProvider.emailError,
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
                        Consumer<SignupProvider>(
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

                        SizedBox(height: screenHeight * 0.025),

                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                value: signupProvider.isTermsAccepted,
                                onChanged: (_) => signupProvider.toggleTerms(),
                                side: BorderSide(color: Colors.grey.shade600),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            FormSubHeadingText(
                              subHeading: "I agree to the terms & conditions",
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.04),

                        RoundedButton(
                          text: 'Sign Up',
                          isLoading: signupProvider.isLoading,
                          onTap: () {
                            signupProvider.sigupWithEmail(
                              context,
                              sginUpformKey,
                            );
                          },
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
