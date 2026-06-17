import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final bool isLoading;
  const RoundedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: screenWidth * 0.5,
        height: screenHeight * 0.065,
        decoration: BoxDecoration(
          color: color ?? AppColors.splashLogoShadowColor,
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        child: Center(
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: screenHeight * 0.03,
                    width: screenWidth * 0.06,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    );
  }
}
