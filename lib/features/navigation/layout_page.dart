import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/features/home/home_page.dart';
import 'package:fit_tracker/features/progress/progress_page.dart';
import 'package:fit_tracker/features/profile/profile_page.dart';
import 'package:fit_tracker/app/cubits/navigation_cubit.dart';
import 'package:fit_tracker/core/theme/colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    final navState = context.watch<NavigationCubit>().state;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: navState,
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
        currentIndex: navState,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: colors.subtitleColor,
        onTap: (index) {
          context.read<NavigationCubit>().setIndex(index);
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


