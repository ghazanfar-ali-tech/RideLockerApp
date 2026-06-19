import 'package:flutter/material.dart';
import 'package:ride_locker_app/views/alert_screen.dart';
import 'package:ride_locker_app/views/app_preferences_screen.dart';
import 'package:ride_locker_app/views/auth_screens/components/account_creation_dashboard.dart';
import 'package:ride_locker_app/views/auth_screens/components/login_successful_dashboard.dart';
import 'package:ride_locker_app/views/auth_screens/forgot_password_screen.dart';
import 'package:ride_locker_app/views/auth_screens/login_screen.dart';
import 'package:ride_locker_app/views/auth_screens/signup_screen.dart';
import 'package:ride_locker_app/views/edit_profile_screen.dart';
import 'package:ride_locker_app/views/helpsupport_screen.dart';
import 'package:ride_locker_app/views/home_screen.dart';
import 'package:ride_locker_app/views/track_screen.dart';
import 'package:ride_locker_app/views/on_borading_screens/on_boarding_screen.dart';
import 'package:ride_locker_app/views/profile_screen.dart';
import 'package:ride_locker_app/views/splash_screen/splash_screen.dart';
import 'package:ride_locker_app/views/subscription_screen.dart';

class AppRoutes {
  // Route name constants
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String track = '/track';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String alerts = '/alerts';
  static const String appPreferences = '/app-preferences';
  static const String helpSupport = '/help-support';
  static const String subscription = '/subscription';
  static const String loginSuccessfulDashboard = '/login-success';
  static const String accountCreationDashboard = '/account-created';

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

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case track:
        return MaterialPageRoute(builder: (_) => const TrackScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      case alerts:
        return MaterialPageRoute(builder: (_) => const AlertScreen());

      case appPreferences:
        return MaterialPageRoute(builder: (_) => const AppPreferencesScreen());

      case helpSupport:
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());

      case subscription:
        return MaterialPageRoute(builder: (_) => const SubscriptionScreen());

      case loginSuccessfulDashboard:
        return MaterialPageRoute(
          builder: (_) => const LoginSuccessfulDashboard(),
        );

      case accountCreationDashboard:
        return MaterialPageRoute(
          builder: (_) => const AccountCreationDashboard(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }
}
