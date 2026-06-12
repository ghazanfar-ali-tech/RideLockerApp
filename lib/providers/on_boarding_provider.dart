import 'package:flutter/material.dart';
import 'package:ride_locker_app/views/auth_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();

  int _currentPage = 0;
  int get currentPage => _currentPage;

  final int totalPages = 3;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/onboarding_images/location.png',
      'heading': 'Real-Time GPS\nTracking',
      'subHeading':
          'Track your motorcycle live from anywhere. Know exactly where your bike is, every second of the day.',
    },
    {
      'image': 'assets/onboarding_images/bell.png',
      'heading': 'Instant Theft Alerts',
      'subHeading':
          'Get notified the moment someone touches your bike. Motion detection keeps you one step ahead of thieves.',
    },
    {
      'image': 'assets/lock.png',
      'heading': 'Remote Engine Lock',
      'subHeading':
          'Immobilize your engine with one tap. No key, no ride — keep your bike safe from anywhere in Pakistan.',
    },
  ];

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void onContinue(BuildContext context) {
    if (_currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding(context);
    }
  }

  void onSkip(BuildContext context) {
    _finishOnboarding(context);
  }

  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_done') ?? false;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
