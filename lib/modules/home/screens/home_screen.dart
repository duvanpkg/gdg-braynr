import 'package:flutter/material.dart';
import 'package:gdg_braynr/modules/home/screens/card_widget.dart';
import 'package:gdg_braynr/modules/home/widgets/vertical_menu.dart';

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
    return Scaffold(
      body: Row(
        children: [
          const VerticalMenu(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++) ...[
                      CardWidget(
                          title: titles[i],
                          description: descriptions[i],
                          icon: icons[i],
                          color: colors[i]),
                      const SizedBox(width: 20),
                    ],
                  ],
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 3; i < 6; i++) ...[
                    CardWidget(
                        title: titles[i],
                        description: descriptions[i],
                        icon: icons[i],
                        color: colors[i]),
                    const SizedBox(width: 20),
                  ],
                ]),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
