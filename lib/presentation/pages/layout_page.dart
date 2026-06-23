import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/pages/home_page.dart';
import 'package:fit_tracker/presentation/pages/progress_page.dart';
import 'package:fit_tracker/presentation/pages/profile_page.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/shared/guest_banner.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            top: true,
            bottom: false,
            child: Column(children: [
              const GuestBanner(),
              Expanded(
                child: IndexedStack(
                  index: appVM.currentIndex,
                  children: const [
                    HomePage(),
                    ProgressPage(),
                    ProfilePage(),
                  ],
                ),
              ),
            ])),
            Positioned(
              left: 20,
              right: 20,
              bottom: bottomInset + 8,
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadowColor,
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.cardColor.withOpacity(0.75),
                        border: Border.all(
                          color: (isDark ? Colors.white : blackColor)
                              .withOpacity(0.08),
                        ),
                      ),
                      child: _DockNavBar(
                        currentIndex: appVM.currentIndex,
                        onTap: (i) => appVM.setIndex(i),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class _DockNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _DockNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / 3;
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              left: 6 + currentIndex * itemWidth,
              top: 6,
              width: itemWidth - 12,
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
            Row(
              children: [
                _dockItem(0, Icons.home_rounded, 'Home',
                    primaryColor, colors.subtitleColor, itemWidth),
                _dockItem(1, Icons.show_chart_rounded, 'Progress',
                    primaryColor, colors.subtitleColor, itemWidth),
                _dockItem(2, Icons.person_rounded, 'Profile',
                    primaryColor, colors.subtitleColor, itemWidth),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _dockItem(
      int index, IconData icon, String label, Color activeColor, Color inactiveColor, double width) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: isSelected ? 26 : 23,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? activeColor : inactiveColor,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
