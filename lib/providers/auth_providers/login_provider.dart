import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_locker_app/components/utils.dart';
import 'package:ride_locker_app/services/auth_services.dart';
import 'package:ride_locker_app/views/auth_screens/components/login_successful_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  LoginProvider() {
    _loadRememberedEmail();
  }

  Future<void> _loadRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('remembered_email') ?? '';
    final wasRemembered = prefs.getBool('remember_me') ?? false;

    if (wasRemembered && savedEmail.isNotEmpty) {
      _emailController.text = savedEmail;
      _rememberMe = true;
      notifyListeners();
    }
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  void loginWithEmail(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    _emailError = null;
    _passwordError = null;

    if (emailController.text.isEmpty) _emailError = 'Please enter email';
    if (!emailController.text.contains('@')) {
      _emailError = 'Please enter a valid email';
    }
    if (passwordController.text.isEmpty) {
      _passwordError = 'Please enter password';
    } else if (passwordController.text.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
    }

    if (!formKey.currentState!.validate()) return;

    _isloading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await AuthService.saveLoginState();

      final prefs = await SharedPreferences.getInstance();
      if (_rememberMe) {
        await prefs.setString('remembered_email', emailController.text.trim());
        await prefs.setBool('remember_me', true);
      } else {
        await prefs.remove('remembered_email');
        await prefs.setBool('remember_me', false);
      }

      Utils.successToast('Login successfully!');

      _emailController.clear();
      _passwordController.clear();

      if (context.mounted) {
        // Navigator.pushNamed(context, AppRoutes.home);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginSuccessfulDashboard()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message}';
      }
      Utils.errorToast(errorMessage);
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    } catch (e) {
      Utils.errorToast('Logout failed: $e');
    }
  }

  void disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }
}
