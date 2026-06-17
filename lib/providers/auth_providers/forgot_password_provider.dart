import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_locker_app/components/utils.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController get emailController => _emailController;
  String? _emailError;
  String? get emailError => _emailError;

  Future<void> sendResetEmail(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    _emailError = null;

    if (emailController.text.isEmpty) _emailError = 'Please enter email';
    if (!emailController.text.contains('@')) {
      _emailError = 'Please enter a valid email';
    }
    if (!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (context.mounted) {
        Utils.successToast('Reset link sent! Check your inbox.');
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        Utils.errorToast(e.toString());
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
