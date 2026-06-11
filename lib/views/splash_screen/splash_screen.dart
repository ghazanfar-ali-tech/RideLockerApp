import 'package:flutter/material.dart';
import 'package:ride_locker_app/core/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.splashLogoShadowColor,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.splashLogoShadowColor.withAlpha(50),
                          blurRadius: 10,
                          spreadRadius: 6,
                        ),
                        BoxShadow(
                          color: AppColors.splashLogoShadowColor.withAlpha(50),
                          blurRadius: 10,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image(
                        height: 50,
                        width: 50,
                        image: AssetImage('assets/lock.png'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'RIDE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2,
                          ),
                        ),
                        TextSpan(
                          text: 'LOCKR',
                          style: TextStyle(
                            color: Color(0xFF39FF6E),
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'SMART ANTI-THEFT SYSTEM',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
