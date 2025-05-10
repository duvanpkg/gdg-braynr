import 'package:flutter/material.dart';
import 'package:gdg_braynr/modules/home/screens/card_widget.dart';

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
    Color(0xFFDEDA9A),
    Color(0xFFA9B6D2),
    Color(0xFFF4AAAA),
    Color(0xFF86C097),
    Color(0xFFC384BE),
    Color(0xFFE49D76),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Braynr'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++) ...[
                  CardWidget(title: titles[i], description: descriptions[i], icon: icons[i], color: colors[i]),
                  const SizedBox(width: 20),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 3; i < 6; i++) ...[
                    CardWidget(title: titles[i], description: descriptions[i], icon: icons[i], color: colors[i]),
                    const SizedBox(width: 20),
                  ],
                ]),
            ]),
          ],
        ),
      ),
    );
  }
}
