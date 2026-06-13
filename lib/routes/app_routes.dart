import 'package:flutter/material.dart';

import 'package:ride_locker_app/views/splash_screen/splash_screen.dart';
import 'package:ride_locker_app/views/on_borading_screens/on_boarding_screen.dart';
import 'package:ride_locker_app/views/auth_screens/login_screen.dart';
import 'package:ride_locker_app/views/auth_screens/signup_screen.dart';
import 'package:ride_locker_app/views/auth_screens/forgot_password_screen.dart';
import 'package:ride_locker_app/views/auth_screens/components/account_creation_dashboard.dart';
import 'package:ride_locker_app/views/auth_screens/components/login_successful_dashboard.dart';
import 'package:ride_locker_app/views/home_screen.dart';
import 'package:ride_locker_app/views/profile_screen.dart';
import 'package:ride_locker_app/views/alert_screen.dart';
import 'package:ride_locker_app/views/edit_profile_screen.dart';
import 'package:ride_locker_app/views/helpsupport_screen.dart';
import 'package:ride_locker_app/views/subscription_screen.dart';
import 'package:ride_locker_app/views/app_preferences_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const accountCreationDashboard = '/account-creation-dashboard';
  static const loginSuccessfulDashboard = '/login-successful-dashboard';
  static const home = '/home';
  static const profile = '/profile';
  static const alerts = '/alerts';
  static const editProfile = '/edit-profile';
  static const helpSupport = '/help-support';
  static const subscription = '/subscription';
  static const appPreferences = '/app-preferences';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case accountCreationDashboard:
        return MaterialPageRoute(builder: (_) => const AccountCreationDashboard());
      case loginSuccessfulDashboard:
        return MaterialPageRoute(builder: (_) => LoginSuccessfulDashboard());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case alerts:
        return MaterialPageRoute(builder: (_) => const AlertScreen());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case helpSupport:
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());
      case subscription:
        return MaterialPageRoute(builder: (_) => const SubscriptionScreen());
      case appPreferences:
        return MaterialPageRoute(builder: (_) => const AppPreferencesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
