import 'package:flutter/material.dart';
import 'package:ride_locker_app/on_borading_screens/on_boarding_components/on_boarding_icon.dart';
import 'package:ride_locker_app/on_borading_screens/on_boarding_components/on_boarding_text.dart';
import 'package:ride_locker_app/on_borading_screens/on_boarding_components/outline_action_button.dart';

class OnboardingSecondView extends StatelessWidget {
  const OnboardingSecondView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OnboardingIcon(
                    imagePath: 'assets/onboarding_images/bell.png',
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  OnboardingTexts(
                    heading: 'Instant Theft Alerts',
                    subHeading:
                        'Get notified the moment someone touches your bike. Motion detection keeps you one step ahead of thieves.',
                  ),
                ],
              ),
            ),

            /////////////////////////////// // => dots go here later
            SizedBox(height: screenHeight * 0.03),
            OutlinedActionButton(text: 'Continue', onTap: () {}),
            SizedBox(height: screenHeight * 0.03),
            OutlinedActionButton(text: 'Skip', onTap: () {}),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
