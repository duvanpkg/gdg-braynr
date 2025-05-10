import 'package:flutter/material.dart';

/// A controller class that manages floating modals in the application
class FloatingModalController {
  // Singleton pattern
  static final FloatingModalController _instance =
      FloatingModalController._internal();
  factory FloatingModalController() => _instance;
  FloatingModalController._internal();

  // Key for the overlay
  final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

  // Current overlay entry
  OverlayEntry? _currentOverlay;

  /// Shows a floating modal with the given widget
  void showFloatingModal(BuildContext context, Widget modalContent,
      {Offset? position}) {
    // Close any existing modal
    hideFloatingModal();

    // Calculate position if not provided
    final screenSize = MediaQuery.of(context).size;
    position ??=
        Offset(screenSize.width / 2 - 150, screenSize.height / 2 - 150);

    // Create the overlay
    _currentOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Modal backdrop (transparent for clicks outside)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: hideFloatingModal,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Modal content
          Positioned(
            left: position!.dx,
            top: position.dy,
            child: Material(
              elevation: 8,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 400),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Close button
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: hideFloatingModal,
                      ),
                    ),
                    // Modal content
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: modalContent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Show the overlay
    final overlay = Overlay.of(context);
    overlay.insert(_currentOverlay!);
  }

  /// Hides the currently showing floating modal
  void hideFloatingModal() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  /// Checks if a modal is currently showing
  bool get isModalShowing => _currentOverlay != null;
}
