import 'package:flutter/material.dart';
import 'package:gdg_braynr/modules/home/widgets/card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const titles = [
    'Write',
    'Study',
    'Take notes',
    'Plan',
    'Resource library',
    'Diagram',
  ];

  static const descriptions = [
    'Write your thoughts and ideas',
    'Study and learn new things',
    'Take notes and organize them',
    'Plan your tasks and activities',
    'Access a library of resources',
    'Create diagrams and flowcharts',
  ];
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'What do you want to focus on today?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return _buildResponsiveGrid(constraints.maxWidth);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid(double width) {
    // Determinamos cuántas tarjetas caben por fila según el ancho disponible
    int cardsPerRow;
    if (width < 600) {
      cardsPerRow = 1; // Móvil: 1 tarjeta por fila
    } else if (width < 900) {
      cardsPerRow = 2; // Tablet: 2 tarjetas por fila
    } else {
      cardsPerRow = 3; // Desktop: 3 tarjetas por fila
    }

    return Wrap(
      spacing: 20, // Espacio horizontal entre tarjetas
      runSpacing: 20, // Espacio vertical entre filas
      alignment: WrapAlignment.center,
      children: List.generate(titles.length, (index) {
        return SizedBox(
          width: cardsPerRow == 1
              ? double.infinity
              : (width - (cardsPerRow - 1) * 20) / cardsPerRow,
          child: CardWidget(
            title: titles[index],
            description: descriptions[index],
            icon: icons[index],
            color: colors[index],
          ),
        );
      }),
    );
  }
}
