import 'package:flutter/material.dart';
import 'package:gdg_braynr/modules/auth/screens/login_screen.dart';
import 'package:gdg_braynr/modules/home/screens/home_screen.dart';

class AuthMiddleware extends StatefulWidget {
  const AuthMiddleware({super.key});

  @override
  State<AuthMiddleware> createState() => _AuthMiddlewareState();
}

class _AuthMiddlewareState extends State<AuthMiddleware> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Auth Middleware'),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('auth')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text('Home'))
          ],
        ),
      ),
    );
  }
}
