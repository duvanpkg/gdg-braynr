import 'package:flutter/material.dart';
import 'package:gdg_braynr/modules/auth/screens/login_screen.dart';
import 'package:gdg_braynr/modules/home/screens/dashboard_container.dart';

class AuthMiddleware extends StatefulWidget {
  const AuthMiddleware({super.key});

  @override
  State<AuthMiddleware> createState() => _AuthMiddlewareState();
}

class _AuthMiddlewareState extends State<AuthMiddleware> {
  bool isLoggedIn = false;

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
                      builder: (context) => const DashboardContainer(),
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
