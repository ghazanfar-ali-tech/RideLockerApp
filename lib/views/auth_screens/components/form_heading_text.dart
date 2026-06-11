import 'package:flutter/material.dart';
import 'package:ride_locker_app/core/app_colors.dart';

class FormHeadingText extends StatelessWidget {
  final String heading;

  const FormHeadingText({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.formHeadingText.createShader(bounds),
          child: Text(
            heading,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
