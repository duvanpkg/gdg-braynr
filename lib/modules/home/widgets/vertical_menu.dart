import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';
import 'package:gdg_braynr/modules/home/widgets/music_player.dart';

class VerticalMenu extends StatefulWidget {
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
  State<VerticalMenu> createState() => _VerticalMenuState();
}

class _VerticalMenuState extends State<VerticalMenu>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      color: primaryColor50,
      padding: const EdgeInsets.all(8.0),
      width: _isExpanded ? 570 : 65,
      child: Column(
        children: [
          // Hamburger menu icon
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: _toggleMenu,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController,
                    color: Colors.white,
                    size: 30,
                  ),
                  if (_isExpanded)
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Menu',
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Home icon
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/icons/Home.png',
                  height: 30,
                  width: 30,
                ),
                if (_isExpanded)
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Home',
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white70,
          ),
          // Iconos generados dinámicamente
          Expanded(
            child: ListView.builder(
              itemCount: VerticalMenu.icons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: VerticalMenu.colors[index],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(VerticalMenu.icons[index],
                            color: Colors.white, size: 30),
                        if (_isExpanded)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                _getMenuItemName(index),
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Below icons
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.chat_bubble_rounded,
                    color: Colors.white, size: 30),
                if (_isExpanded)
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Chats',
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (!_isExpanded)
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF717171),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.graphic_eq, color: Colors.white, size: 30),
                ],
              ),
            ),
          if (_isExpanded) const MusicPlayer(),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: greenAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/doro_logo.png',
                  height: 30,
                  width: 30,
                ),
                if (_isExpanded)
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'DORO',
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMenuItemName(int index) {
    const titles = [
      'Write',
      'Study',
      'Take notes',
      'Plan',
      'Resource library',
      'Diagram',
    ];
    return index < titles.length ? titles[index] : 'Element';
  }
}
