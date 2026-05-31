import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/pages/home_page.dart';
import 'package:fit_tracker/presentation/pages/progress_page.dart';
import 'package:fit_tracker/presentation/pages/profile_page.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: appVM.currentIndex,
        children: [
          HomePage(key: ValueKey('home_$isDark')),
          ProgressPage(key: ValueKey('progress_$isDark')),
          ProfilePage(
            key: ValueKey('profile_$isDark'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 13,
        unselectedFontSize: 10,
        selectedIconTheme: const IconThemeData(size: 27),
        unselectedIconTheme: const IconThemeData(size: 20),
        backgroundColor: colors.cardColor,
        currentIndex: appVM.currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: colors.subtitleColor,
        onTap: (index) {
          appVM.setIndex(index);
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


