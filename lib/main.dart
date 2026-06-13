import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/constants.dart';

import 'package:ride_locker_app/providers/auth_providers/login_provider.dart';
import 'package:ride_locker_app/providers/auth_providers/signup_provider.dart';
import 'package:ride_locker_app/providers/on_boarding_provider.dart';

import 'providers/home_provider.dart';
import 'providers/notification_provider.dart';
import 'package:ride_locker_app/routes/app_routes.dart';
import 'package:ride_locker_app/views/profile_screen.dart';

void main() async {
  // google-services.json
  // lib/constants.dart

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => BikeProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
        ),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}