import 'package:flutter/material.dart';
import 'package:gdg_braynr/modules/home/widgets/vertical_menu.dart';
import 'package:gdg_braynr/modules/home/screens/home_screen.dart';
import 'package:gdg_braynr/modules/home/screens/practices/practices_screen.dart';

/// A container widget that manages the layout with a vertical menu
/// and content area that can change based on navigation.
class DashboardContainer extends StatefulWidget {
  const DashboardContainer({super.key});

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  // Current selected index from menu (0 = Home, 1 = Study/Practices, etc.)
  int _selectedIndex = 0;

  // Function to be passed to VerticalMenu for handling navigation changes
  void _onMenuItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Get the appropriate content based on selected index
  Widget _getContent() {
    switch (_selectedIndex) {
      case 0: // Home
        return const HomeScreen();
      case 1:
        return const Scaffold();
      case 2: // Study/Practices
        return const PracticesScreen();
      case 3:
        return const Scaffold();
      case 4:
        return const Scaffold();
      case 5:
        return const Scaffold();
      case 6:
        return const Scaffold();
      default:
        return const HomeScreen(); // Default to home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // The vertical menu that remains consistent
            VerticalMenu(
              selectedIndex: _selectedIndex,
              onItemTapped: _onMenuItemTapped,
            ),

            // The content area that changes based on navigation
            Expanded(
              child: _getContent(),
            ),
          ],
        ),
      ),
    );
  }
}
