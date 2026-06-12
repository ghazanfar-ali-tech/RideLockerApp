import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/core/app_colors.dart';

import 'package:ride_locker_app/providers/on_boarding_provider.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(provider.totalPages, (index) {
        final bool isActive = index == provider.currentPage;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.splashLogoShadowColor
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
