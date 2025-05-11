import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/services/pingu_services.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';
import 'package:gdg_braynr/global/widgets/floating_modal_controller.dart';
import 'package:gdg_braynr/modules/auth/screens/login_screen.dart';
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
      home: const LoginScreen(),
      // Use the overlay key from the controller
      builder: (context, child) {
        return Overlay(
          key: modalController.overlayKey,
          initialEntries: [
            OverlayEntry(
              builder: (context) => Stack(
                children: [
                  if (child != null) child, // Render the current screen
                  const Positioned(
                    bottom: 0,
                    right: 20,
                    child: PinguWidget(),
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

class PinguWidget extends StatefulWidget {
  const PinguWidget({super.key});

  @override
  State<PinguWidget> createState() => _PinguWidgetState();
}

class _PinguWidgetState extends State<PinguWidget> {
  String? pinguResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (pinguResponse != null && pinguResponse!.isNotEmpty)
          Stack(
            clipBehavior:
                Clip.none, // Allow triangle to extend outside stack bounds
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(
                    bottom: 16,
                    right: 60,
                    left: 20), // Added left margin and increased right margin
                constraints: const BoxConstraints(
                  maxWidth: 260, // Adjusted max width
                  minWidth: 100,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Pingu says: ${pinguResponse!}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Funnel_Display',
                    color: primaryColor50,
                    fontWeight: FontWeight.w400,
                    backgroundColor: Colors.transparent,
                    decoration: TextDecoration.none,
                  ),
                  maxLines: null,
                  overflow: TextOverflow.visible,
                ),
              ),
              // Triangle pointer
              Positioned(
                right: 80, // Move triangle more to the left (increased from 25)
                bottom: 0,
                child: CustomPaint(
                  size: const Size(16, 16),
                  painter: TrianglePainter(),
                ),
              ),
            ],
          ),
        GestureDetector(
          onTap: () async {
            final response = await PinguService().pinguCall(
              content: 'home screen',
              prompt: 'What do you think about this app?',
            );

            print('Pingu response: $response');

            if (response != null) {
              setState(() {
                pinguResponse = response;
              });
            }
          },
          child: Image.asset(
            'assets/images/pingu/pingu.gif',
            width: 130,
            height: 130,
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
