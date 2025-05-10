import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gdg_braynr/global/middlewares/auth_middleware.dart';

Future<void> main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Braynr',
      theme: AppTheme.normalTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthMiddleware(),
    );
  }
}
