import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_screen.dart';
import 'notification_provider.dart';

void main() => runApp(
  ChangeNotifierProvider(create: (_) => NotificationProvider(), child: const RideLockrApp()),
);