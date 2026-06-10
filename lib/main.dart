import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'providers/home_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = Colors.greenAccent.shade400;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RideLockr - Home',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF0F1113),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Color(0xFF00C853)),
      ),
      home: const HomeScreen(),
    );
  }
}

