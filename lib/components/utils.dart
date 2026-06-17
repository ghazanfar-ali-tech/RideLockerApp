import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Utils {
  static void successToast(String message) => showToast(
    message,
    backgroundColor: AppColors.splashLogoShadowColor,
    textStyle: const TextStyle(color: Colors.black),
  );

  static void errorToast(String message) => showToast(
    message,
    backgroundColor: const Color(0xFFD32F2F),
    textStyle: const TextStyle(color: Colors.white),
  );

  static void warningToast(String message) => showToast(
    message,
    backgroundColor: const Color(0xFFFFA000),
    textStyle: const TextStyle(color: Colors.black),
  );

  static void infoToast(String message) => showToast(
    message,
    backgroundColor: const Color(0xFF1A1A1A),
    textStyle: const TextStyle(color: Colors.white),
  );
}
