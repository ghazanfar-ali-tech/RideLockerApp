import 'package:flutter/material.dart';
import 'alert_tab.dart';

void main() {
  runApp(const RideLockrApp());
}

class RideLockrApp extends StatelessWidget {
  const RideLockrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideLockr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFF00FFAA),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFAA),
          secondary: Color(0xFF00D4FF),
          surface: Color(0xFF1E1E1E),
          background: Color(0xFF0A0A0A),
        ),
      ),
      home: const AlertScreen(),
    );
  }
}