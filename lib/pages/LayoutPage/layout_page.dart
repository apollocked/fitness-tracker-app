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
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _updatePages();
  }

  void _updatePages() {
    _pages = [
      const HomePage(),
      const ProgressPage(),
      ProfilePage(
        onThemeChanged: () {
          widget.onThemeChanged?.call(currentUser?['darkMode'] ?? false);
          _refreshAllPages();
        },
      ),
    ];
  }

  void _refreshAllPages() {
    setState(() {
      _updatePages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
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
