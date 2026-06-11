import 'package:flutter/material.dart';
import 'package:ride_locker_app/core/app_colors.dart';

class FormSubHeadingText extends StatelessWidget {
  final String subHeading;

  const FormSubHeadingText({super.key, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          subHeading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.blue,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
