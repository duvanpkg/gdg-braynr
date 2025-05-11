import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/services/pingu_services.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';
import 'package:gdg_braynr/global/widgets/floating_modal_controller.dart';
import 'package:gdg_braynr/modules/auth/screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

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
  Timer? _autoCloseTimer;
  bool _isLoading = false; // Add this loading state variable

  @override
  void dispose() {
    _autoCloseTimer?.cancel();
    super.dispose();
  }

  void _startAutoCloseTimer() {
    _autoCloseTimer?.cancel();
    _autoCloseTimer = Timer(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          pinguResponse = null;
        });
      }
    });
  }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pinguResponse = null;
                            });
                            _autoCloseTimer?.cancel();
                          },
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: primaryColor50,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      pinguResponse!,
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
                  ],
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
        // Show loading indicator if isLoading is true
        // if (_isLoading)
        //   Container(
        //     padding: const EdgeInsets.all(12),
        //     margin: const EdgeInsets.only(bottom: 16, right: 60, left: 20),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(16),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.1),
        //           blurRadius: 10,
        //           offset: const Offset(0, 4),
        //         ),
        //       ],
        //     ),
        //     child: const CircularProgressIndicator(
        //       valueColor: AlwaysStoppedAnimation<Color>(primaryColor50),
        //       strokeWidth: 3,
        //     ),
        //   ),
        GestureDetector(
          onTap: () async {
            // Set loading to true before API call
            setState(() {
              _isLoading = true;
            });

            final response = await PinguService().pinguCall(
              content: 'home screen',
              prompt:
                  'help me study, but give me short answers and talk like I havent asked like it was your decision to talks',
            );

            print('Pingu response: $response');

            // Update state with response and set loading to false
            setState(() {
              pinguResponse = response;
              _isLoading = false;
            });

            if (response != null) {
              _startAutoCloseTimer();
            }
          },
          child: _isLoading
              ? Image.asset(
                  'assets/images/pingu/pengu_loading.gif',
                  width: 130,
                  height: 130,
                )
              : Image.asset(
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
