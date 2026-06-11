import 'package:flutter/material.dart';
import 'package:ride_locker_app/on_borading_screens/on_boarding_components/on_boarding_icon.dart';
import 'package:ride_locker_app/on_borading_screens/on_boarding_components/on_boarding_text.dart';
import 'package:ride_locker_app/on_borading_screens/on_boarding_components/outline_action_button.dart';

class OnboardingThirdView extends StatelessWidget {
  const OnboardingThirdView({super.key});

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
                  OnboardingIcon(imagePath: 'assets/lock.png'),
                  SizedBox(height: screenHeight * 0.02),
                  OnboardingTexts(
                    heading: 'Remote Engine Lock',
                    subHeading:
                        'Immobilize you engine with one tap. No key, no ride keep your bike safe from anywhere in Pakistan.',
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
