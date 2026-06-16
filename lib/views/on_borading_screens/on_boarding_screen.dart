import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/views/on_borading_screens/on_boarding_components/dot_indicator.dart';
import 'package:ride_locker_app/views/on_borading_screens/on_boarding_components/on_boarding_icon.dart';
import 'package:ride_locker_app/views/on_borading_screens/on_boarding_components/on_boarding_text.dart';
import 'package:ride_locker_app/views/on_borading_screens/on_boarding_components/outline_action_button.dart';
import 'package:ride_locker_app/providers/on_boarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingBody();
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final provider = context.read<OnboardingProvider>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: provider.pageController,
              itemCount: provider.totalPages,
              onPageChanged: provider.onPageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnboardingIcon(
                        imagePath: provider.pages[index]['image']!,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      OnboardingTexts(
                        heading: provider.pages[index]['heading']!,
                        subHeading: provider.pages[index]['subHeading']!,
                      ),
                      SizedBox(height: screenHeight * 0.06),
                      const DotsIndicator(),
                    ],
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              children: [
                Consumer<OnboardingProvider>(
                  builder: (context, provider, _) {
                    return OutlinedActionButton(
                      text: provider.currentPage == provider.totalPages - 1
                          ? 'Get Started'
                          : 'Continue',
                      onTap: () => provider.onContinue(context),
                    );
                  },
                ),

                SizedBox(height: screenHeight * 0.03),

                OutlinedActionButton(
                  text: 'Skip',
                  onTap: () => provider.onSkip(context),
                ),

                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
