import 'package:flutter/material.dart';
import 'package:myapp/pages/HomePage/home_page.dart';
import 'package:myapp/pages/progress/progress_page.dart';
import 'package:myapp/pages/Profile/profile_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart';

class LayoutPage extends StatefulWidget {
  final Function(bool)? onThemeChanged;

  const LayoutPage({super.key, this.onThemeChanged});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

  @override
  void didUpdateWidget(LayoutPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Rebuild when widget updates (theme change propagated from main)
    setState(() {});
  }

  void _handleThemeChange() {
    // Call parent's theme change callback
    widget.onThemeChanged?.call(currentUser?['darkMode'] ?? false);

    // Force immediate rebuild of this widget and all children
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(key: ValueKey('home_${isDarkMode()}')),
          ProgressPage(key: ValueKey('progress_${isDarkMode()}')),
          ProfilePage(
            key: ValueKey('profile_${isDarkMode()}'),
            onThemeChanged: _handleThemeChange,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: getCardColor(),
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: getSubtitleColor(),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
