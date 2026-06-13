import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_locker_app/comonents/utils.dart';
import 'package:ride_locker_app/views/auth_screens/components/account_creation_dashboard.dart';
import 'package:ride_locker_app/routes/app_routes.dart';
import 'package:ride_locker_app/services/auth_services.dart';

class SignupProvider extends ChangeNotifier {
  // final GlobalKey<FormState> sginUpformKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get phoneNumberController => _phoneNumberController;

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _phoneNumberError;

  String? get nameError => _nameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get phoneNumberError => _phoneNumberError;

  bool _isPasswordVisible = false;
  bool _isTermsAccepted = false;
  bool get isTermsAccepted => _isTermsAccepted;

  bool get isPasswordVisible => _isPasswordVisible;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool _isloading = false;
  bool get isLoading => _isloading;

  void sigupWithEmail(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    _nameError = null;
    _emailError = null;
    _passwordError = null;
    _phoneNumberError = null;

    if (nameController.text.isEmpty) _nameError = 'Please enter name';
    if (emailController.text.isEmpty) _emailError = 'Please enter email';
    if (!emailController.text.contains('@')) {
      _emailError = 'Please enter a valid email';
    }
    if (passwordController.text.isEmpty) {
      _passwordError = 'Please enter password';
    } else if (passwordController.text.length < 6) {
      _passwordError = 'Password must be at least 6 characters long!';
    }
    if (phoneNumberController.text.isEmpty) {
      _phoneNumberError = 'Please enter phone number';
    } else if (phoneNumberController.text.length < 10) {
      _phoneNumberError = 'Phone number must be at least 10 digits long!';
    }

    if (!formKey.currentState!.validate()) return;

    if (!_isTermsAccepted) {
      Utils.warningToast('Please accept the terms & conditions!');
      return;
    }
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      Utils.warningToast('Please fill all the fields!');
      return;
    }

    if (passwordController.text.length < 6) {
      Utils.warningToast('Password must be at least 6 characters long!');
      return;
    }

    _isloading = true;
    notifyListeners();

    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await AuthService.saveLoginState();
      final user = FirebaseAuth.instance.currentUser;
      final name = user?.displayName ?? user?.email?.split('@').first ?? 'User';

      nameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneNumberController.clear();

      if (context.mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.accountCreationDashboard,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak.';
          break;
        default:
          errorMessage = 'Error: ${e.message}';
      }
      debugPrint(errorMessage);
      Utils.errorToast(errorMessage);
    } catch (e) {
      debugPrint(e.toString());
      Utils.errorToast('An unexpected error occurred: $e');
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  void toggleTerms() {
    _isTermsAccepted = !_isTermsAccepted;
    notifyListeners();
  }

  void disposeControllers() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
  }
}
