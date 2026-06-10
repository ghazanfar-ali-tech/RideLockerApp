import 'package:flutter/material.dart';
import 'HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = Colors.greenAccent.shade400;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RideLockr - Home',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF0F1113),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Color(0xFF00C853)),
      ),
      home: const HomeScreen(),
    );
  }
}

