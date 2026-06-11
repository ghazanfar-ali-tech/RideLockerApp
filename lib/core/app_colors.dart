import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color splashLogoShadowColor = Colors.green;

  static const Color gradientStart = Color(0xFF00DD90);
  static const Color gradientMiddle = Color(0xFF00BAE5);
  static const Color gradientEnd = Color(0xFF00AEEF);

  static const LinearGradient formHeadingText = LinearGradient(
    colors: [gradientStart, gradientMiddle, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Color blue = Color(0xFF00BAE5);
}
