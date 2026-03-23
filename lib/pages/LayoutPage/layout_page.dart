import 'package:flutter/material.dart';
import 'package:myapp/pages/HomePage/home_page.dart';
import 'package:myapp/pages/progress/progress_page.dart';
import 'package:myapp/pages/Profile/profile_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 13,
        unselectedFontSize: 10,
        selectedIconTheme: const IconThemeData(size: 27),
        unselectedIconTheme: const IconThemeData(size: 20),
        backgroundColor: getCardColor(),
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
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
