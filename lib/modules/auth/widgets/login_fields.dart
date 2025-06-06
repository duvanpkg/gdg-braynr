import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';
import 'package:gdg_braynr/global/widgets/custom_fields.dart';
import 'package:gdg_braynr/modules/home/screens/dashboard_container.dart';

class LoginFields extends StatelessWidget {
  const LoginFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/login_banner.png',
            height: MediaQuery.of(context).size.height * 0.70,
          ),
          Container(
              width: MediaQuery.of(context).size.height * 0.50,
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: Colors.white,
                  width: 0.3,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF999999), blackAccent],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 68,
                      // close letter spacing
                      letterSpacing: -1.5,

                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(color: Colors.white70),
                  CustomTextField(
                    labelText: 'Email',
                    labelStyle: const TextStyle(fontSize: 16),
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 16),
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'I forgot my password',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardContainer(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
