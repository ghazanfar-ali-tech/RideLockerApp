import 'package:flutter/material.dart';
import 'package:ride_locker_app/comonents/custom_text_field.dart';
import 'package:ride_locker_app/comonents/round_button.dart';
import 'package:ride_locker_app/views/auth_screens/components/form_heading_text.dart';
import 'package:ride_locker_app/views/auth_screens/components/form_subheading_text.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
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
                prefixIcon: Icons.person_outline,
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
                hint: '1234 5678 9012 3456',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
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
              customTextFormField(
                hint: 'Password',
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.visibility_off_outlined,
                obscureText: true,
              ),

              SizedBox(height: screenHeight * 0.025),

              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: false,
                      onChanged: (_) {},
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

              RoundedButton(text: 'Sign Up', onTap: () {}),

              SizedBox(height: screenHeight * 0.025),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {},
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
        ),
      ),
    );
  }
}
