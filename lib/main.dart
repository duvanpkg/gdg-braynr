import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/middlewares/auth_middleware.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';
import 'package:gdg_braynr/global/widgets/floating_modal_controller.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get a reference to the floating modal controller
    final FloatingModalController modalController = FloatingModalController();

    return MaterialApp(
      title: 'Braynr',
      theme: AppTheme.normalTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthMiddleware(),
      // Use the overlay key from the controller
      builder: (context, child) {
        return Overlay(
          key: modalController.overlayKey,
          initialEntries: [
            OverlayEntry(
              builder: (context) => Stack(
                children: [
                  if (child != null) child, // Render the current screen
                  Positioned(
                    bottom: 0,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint('Penguin tapped!');
                      },
                      child: Image.asset(
                        'assets/images/pingu/pingu.gif',
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
