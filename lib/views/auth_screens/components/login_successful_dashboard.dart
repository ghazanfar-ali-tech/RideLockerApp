import 'package:flutter/material.dart';
import 'package:ride_locker_app/components/round_button.dart';
import 'package:ride_locker_app/core/app_colors.dart';
import 'package:ride_locker_app/views/home_screen.dart';

class LoginSuccessfulDashboard extends StatelessWidget {
  const LoginSuccessfulDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: screenWidth * 0.04,
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.038,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenWidth * 0.18,
                      width: screenWidth * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.splashLogoShadowColor.withOpacity(0.2),
                        border: Border.all(
                          color: AppColors.splashLogoShadowColor,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.splashLogoShadowColor,
                        size: screenWidth * 0.08,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.formHeadingText.createShader(bounds),
                      child: Text(
                        "You are Logged In Successfully",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    Text(
                      'Your can explore now',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.05),
                    RoundedButton(
                      text: 'Continue to Dashboard',
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
