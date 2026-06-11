import 'package:flutter/material.dart';
import 'package:ride_locker_app/core/app_colors.dart';

class OnboardingIcon extends StatelessWidget {
  final String imagePath;

  const OnboardingIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.splashLogoShadowColor, width: 1.5),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 160,
        width: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1A1A1A),
        ),
        child: Padding(
          padding: const EdgeInsets.all(41.0),
          child: Image(color: Colors.green, image: AssetImage(imagePath)),
        ),
      ),
    );
  }
}
