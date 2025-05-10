import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';

class VerticalMenu extends StatelessWidget {
  const VerticalMenu({super.key});

  static const icons = [
    Icons.edit,
    Icons.book,
    Icons.note,
    Icons.calendar_today,
    Icons.library_books,
    Icons.auto_graph,
  ];

  static const colors = [
    Color(0xFFF94144),
    Color(0xFF90BE6D),
    Color(0xFFF3722C),
    Color(0xFF43AA8B),
    Color(0xFFC361BB),
    Color(0xFF577590),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor50,
      padding: const EdgeInsets.all(8.0),
      width: 60,
      child: ListView(
        children: [
          // Home icon (mantiene el diseño especial)
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
          // Genera los demás iconos mediante un ciclo
          ...List.generate(
            icons.length,
            (index) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icons[index], color: Colors.white, size: 30),
                ),
                if (index < icons.length - 1) const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
