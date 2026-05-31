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
          ProfilePage(key: ValueKey('profile_$isDark')),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.07),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, appVM, 0, Icons.home_rounded,
                    Icons.home_outlined, 'Home'),
                _buildNavItem(context, appVM, 1, Icons.show_chart_rounded,
                    Icons.show_chart, 'Progress'),
                _buildNavItem(context, appVM, 2, Icons.person_rounded,
                    Icons.person_outline, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    AppViewModel appVM,
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
  ) {
    final isSelected = appVM.currentIndex == index;
    return GestureDetector(
      onTap: () => appVM.setIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? primaryColor.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected
                  ? primaryColor
                  : Theme.of(context)
                      .extension<AppColorsExtension>()!
                      .subtitleColor,
              size: isSelected ? 26 : 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected
                    ? primaryColor
                    : Theme.of(context)
                        .extension<AppColorsExtension>()!
                        .subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
