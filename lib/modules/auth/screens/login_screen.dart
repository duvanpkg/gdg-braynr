import 'package:flutter/material.dart';
import 'package:gdg_braynr/modules/auth/widgets/login_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/large_logo_light.png',
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          const Expanded(
            child: LoginFields(),
          ),
        ],
      ),
    );
  }
}
