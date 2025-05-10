import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';

class VerticalMenu extends StatelessWidget {
  const VerticalMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor50,
      padding: const EdgeInsets.all(8.0),
      width: 60,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/icons/Home.png',
            ),
          ),
          const Divider(
            color: Colors.white70,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/icons/Pencil.png',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/icons/Book_Reading.png',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/icons/Bookmark.png',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/icons/Project.png',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/icons/Task.png',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/icons/Mind_Map.png',
            ),
          ),
        ],
      ),
    );
  }
}
