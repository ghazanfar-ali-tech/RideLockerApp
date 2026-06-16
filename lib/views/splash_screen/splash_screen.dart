import 'package:flutter/material.dart';
import 'package:ride_locker_app/core/app_colors.dart';
import 'package:ride_locker_app/views/auth_screens/login_screen.dart';
import 'package:ride_locker_app/views/home_screen.dart';
import 'package:ride_locker_app/views/on_borading_screens/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();

    final bool onboardingDone = prefs.getBool('onboarding_done') ?? false;
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    Widget destination;

    if (!onboardingDone) {
      destination = const OnboardingScreen();
    } else if (isLoggedIn) {
      destination = HomeScreen();
    } else {
      destination = LoginScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

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
                    child: const Center(
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
