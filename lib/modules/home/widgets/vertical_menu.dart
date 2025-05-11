import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';
import 'package:gdg_braynr/global/widgets/floating_modal_controller.dart';
import 'package:gdg_braynr/modules/home/widgets/music_player.dart';

class VerticalMenu extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const VerticalMenu({
    super.key,
    this.selectedIndex = 0,
    required this.onItemTapped,
  });

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
  final FloatingModalController _modalController = FloatingModalController();

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

  void _showMusicPlayerModal(BuildContext context) {
    _modalController.showFloatingModal(
      context,
      const MusicPlayer(),
      position: Offset(
        MediaQuery.of(context).size.width * 0.05, // 5% from left edge
        MediaQuery.of(context).size.height * 0.6, // 60% from top edge
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define constants for our menu indexes
    const int homeIndex = 0;
    const int chatIndex = 7; // After the 6 dynamic items
    const int musicIndex = 8;
    const int doroIndex = 9;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      color: primaryColor50,
      padding: const EdgeInsets.all(8.0),
      width: _isExpanded ? 270 : 65,
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
          GestureDetector(
            onTap: () {
              widget.onItemTapped(homeIndex);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF717171),
                borderRadius: BorderRadius.circular(10),
                boxShadow: widget.selectedIndex == homeIndex
                    ? [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.7),
                          blurRadius: 12,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
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
          ),
          const Divider(
            color: Colors.white70,
          ),
          // Iconos generados dinámicamente
          Expanded(
            child: ListView.builder(
              itemCount: VerticalMenu.icons.length,
              itemBuilder: (context, index) {
                // Adjust index to start after Home (index 0)
                final int actualIndex = index + 1;
                final bool isSelected = widget.selectedIndex == actualIndex;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () => widget.onItemTapped(actualIndex),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: VerticalMenu.colors[index],
                        borderRadius: BorderRadius.circular(10),
                        // Add a subtle glow effect when selected
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: VerticalMenu.colors[index]
                                      .withOpacity(0.7),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                )
                              ]
                            : null,
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
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Chat icon
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
              boxShadow: widget.selectedIndex == chatIndex
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.7),
                        blurRadius: 12,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: InkWell(
              onTap: () => widget.onItemTapped(chatIndex),
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
          ),
          const SizedBox(height: 10),
          // Music player icon
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF717171),
              borderRadius: BorderRadius.circular(10),
              boxShadow: widget.selectedIndex == musicIndex
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.7),
                        blurRadius: 12,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: InkWell(
              onTap: () {
                _showMusicPlayerModal(context);
                widget.onItemTapped(musicIndex);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.graphic_eq, color: Colors.white, size: 30),
                  if (_isExpanded)
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Music Player',
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
          // DORO Icon
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: greenAccent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: widget.selectedIndex == doroIndex
                  ? [
                      BoxShadow(
                        color: greenAccent.withOpacity(0.7),
                        blurRadius: 12,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: InkWell(
              onTap: () {
                _showMusicPlayerModal(context);
                widget.onItemTapped(doroIndex);
              },
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
